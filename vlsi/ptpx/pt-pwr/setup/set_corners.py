#!/usr/bin/python2

# Stevo Bailey
# stevo@berkeley.edu
#
# This script finds operating corners in each ST library using
# the packaging/vc.bbview file. Make sure the vc.bbview files 
# are correct if making a custom library!

import sys, os


def parse_corner(line, headers, pvts, lib_list, v2):
  line = line.split() 
  cur_max = lib_list[1]
  cur_min = lib_list[2]
  for pvt in pvts:
    pvt = pvt.split('_')
    v_index = 0
    try:
      v_index = headers.index('V')
    except:
      v_index = headers.index('V1')
    vs_index = ''
    try:
      vs_index = headers.index('VS')
    except:
      pass
    try:
      vs_index = headers.index('V1S')
    except:
      pass
    if pvt[0] in line[headers.index('P')] and float(pvt[1]) == float(line[v_index]) and float(pvt[2]) == float(line[headers.index('T')]) and '0y' in line[headers.index('AGING')] and ((vs_index and float(line[vs_index]) == 0) or not vs_index) and ((v2 and float(line[headers.index('V2')]) == v2) or not v2 or (v2 == 'V2' and float(line[headers.index('V2')]) == float(pvt[1]))):
      name = line[headers.index('NAME')] + ' ' + '_'.join(pvt)
      if 'Sig' in name: # [ben] Some new libraries have four PVT matches - need to pick one
        if pvt[0] == 'ss' and 'RCmax' not in name: continue
        elif pvt[0] == 'ff' and 'RCmin' not in name: continue
        elif pvt[0] == 'tt' and 'RCmax' not in name: continue
      if name not in lib_list[0]:
        lib_list[0].append(name)
      if not cur_max:
        cur_max = name
      else:
        cur_max_pvt = cur_max.split()[1].split('_') 
        if pvt[0].count('f') >= cur_max_pvt[0].count('f') or ('tt' in pvt[0] and 'ss' in cur_max_pvt[0]) and float(pvt[1]) >= float(cur_max_pvt[1]) and float(pvt[2]) <= float(cur_max_pvt[2]):
          cur_max = name
      if not cur_min:
        cur_min = name
      else:
        cur_min_pvt = cur_min.split()[1].split('_') 
        if (pvt[0].count('s') >= cur_min_pvt[0].count('s')) or ('tt' in pvt[0] and 'ff' in cur_min_pvt[0]) and float(pvt[1]) <= float(cur_min_pvt[1]) and float(pvt[2]) >= float(cur_min_pvt[2]):
          cur_min = name
  lib_list[1] = cur_max
  lib_list[2] = cur_min
  return lib_list

if len(sys.argv) < 4:
  print 'Usage: ./set_corners.py <vars file> \'<cell db dirs>\' \'<corners>\''
  print '   for corners, sytax is P_V_T'
  sys.exit(1)

# parse input arguments
file = sys.argv[1] 
libs = sys.argv[2].split()
pvts = sys.argv[3].split()
# check inputs
for pvt in pvts:
  pvt1 = pvt.split('_')
  if len(pvt1) != 3:
    print 'Error: Bad PVT format: ' + pvt 
    sys.exit(1)
  try:
    x = float(pvt1[1])
    x = float(pvt1[2])
  except:
    print 'Error: Bad PVT format: ' + pvt 
    sys.exit(1)
  if not 't' in pvt1[0] and not 's' in pvt1[0] and not 'f' in pvt1[0]:
    print 'Error: Bad PVT format: ' + pvt 
    sys.exit(1)
  if len(pvt1[0]) != 2:
    print 'Error: Bad PVT format: ' + pvt 
    sys.exit(1)

# special case for testmux V2
testmux_v2 = 1.65
ls_v2 = 0.90

# find each process corner for each lib
target_lib_files = ''
ip_lib_files = ''
min_lib_files = ''
for lib in libs:
  print lib
  
  # parse vc.bbview file
  conds_flag = 0
  headers = ''
  lib_list = [[], '', ''] # format is all libs, max library, min library
  bbview = lib + '/packaging/vc.bbview'
  if not os.path.isfile(bbview):
    print 'Error: file not found: ' + bbview
    print 'Did you update the submodules? Do you need to remake the lib directory?'
    sys.exit(1)
  with open(bbview, 'r') as f:
    for line in f.readlines():
      if 'CONDS' in line:
        line = line.replace('CONDS TIMING NAME', 'NAME')
        headers = line.split()
        conds_flag = 1
      elif conds_flag and 'END' in line:
        break
      elif conds_flag:
        v2 = 0
        if 'TESTMUX' in lib:
          v2 = testmux_v2
        if 'SHIFT' in lib:
          v2 = 'V2'
        lib_list = parse_corner(line, headers, pvts, lib_list, v2) 

  # check results
  lib_name = os.path.basename(os.path.normpath(lib))
  if len(lib_list[0]) == 0:
    print 'Error: No valid corner found for lib ' + lib_name
    sys.exit(1)
  for pvt in pvts:
    if not pvt in ' '.join(lib_list[0]):
      print 'Warning: PVT ' + pvt + ' not found in lib ' + lib_name

  # append to text
  for lib in lib_list[0]:
    if '_CORE_' in lib_name or '_COREPBP' in lib_name or '_CLK_' in lib_name or '_PR_' in lib_name or 'SHIFT' in lib_name:
      target_lib_files += ' ' + lib_name + '_' + lib.split()[0] + ".db"
    else:
      ip_lib_files += ' ' + lib_name + '_' + lib.split()[0] + ".db"
  if lib_list[1].split()[0] == lib_list[2].split()[0]:
    print 'Warning: min and max library are the same for lib ' + lib_name + ', omitting from min_library list'
  else:
    min_lib_files += ' ' + lib_name + '_' + lib_list[1].split()[0] + '.db ' + lib_name + '_' + lib_list[2].split()[0] + ".db"

# print to file
# [stevo]: only put core, clock, and pr libraries in target library files
# put IP, pad frame, SRAM, etc. libraries in additional link lib files
with open(file, 'a') as f:
  f.write('set TARGET_LIBRARY_FILES \"' + target_lib_files + '\";\n')
  f.write('set MIN_LIBRARY_FILES \"' + min_lib_files + '\";\n')
  f.write('set ADDITIONAL_LINK_LIB_FILES \"' + ip_lib_files + '\";\n')
