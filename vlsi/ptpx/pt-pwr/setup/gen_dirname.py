#! /usr/bin/python2

from subprocess import call, Popen, PIPE, STDOUT
from time import sleep
import sys
import fileinput
import re
from glob import glob
import os
import random
import string

def get_rand_name(char):
  adjs = []
  nouns = []
  for line in open('setup/index.adj', 'r'):
    if line.startswith(char):
      adjs.append(line.strip())
    elif len(adjs) > 0:
      break
  for line in open('setup/index.noun', 'r'):
    if line.startswith(char):
      nouns.append(line.strip())
    elif len(nouns) > 0:
      break
  return random.choice(adjs) + '_' + random.choice(nouns)

# create log directory, and set symlink to it
chars = list(string.lowercase)
runs = glob('*')
char_counts = [0]*26
if len(runs) > 0:
  for run in runs:
    run = os.path.basename(run)
    if 'build-' in run and len(run) > 6:
      first_char = run[6]
      if first_char in chars:
        char_counts[chars.index(first_char)] += 1
max = 0
new_char = 0
for i, count in enumerate(char_counts):
  if count == 0:
    new_char = i
    break
  elif count > max:
    max = count
  elif count < max:
    new_char = i
    break
dir = get_rand_name(chars[new_char])
print dir
