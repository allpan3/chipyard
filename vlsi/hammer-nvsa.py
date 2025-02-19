#!/usr/bin/env python3
#
# NOTE: this ExampleDriver works for asap7 and nangate45. the custom hooks are
# only used for asap7 though.

import os

from hammer.vlsi import CLIDriver, HammerTool, HammerToolHookAction

from typing import Dict, Callable, Optional, List

def example_place_tap_cells(x: HammerTool) -> bool:
    if x.get_setting("vlsi.core.technology") == "asap7":
        x.append('''
# TODO
# Place custom TCL here
''')
    return True

def example_add_fillers(x: HammerTool) -> bool:
    if x.get_setting("vlsi.core.technology") == "asap7":
        x.append('''
# TODO
# Place custom TCL here
''')
    return True

def example_tool_settings(x: HammerTool) -> bool:
    if x.get_setting("vlsi.core.technology") == "asap7":
        x.append('''
# TODO
# Place custom TCL here
set_db route_design_bottom_routing_layer 2
set_db route_design_top_routing_layer 7
''')
    return True

def syn_ungroup(x: HammerTool) -> bool:
    x.append('''
# Ungroup VSM module in Gemmini to allow retiming to take effect
if {[get_db hinsts system/tile_prci_domain/tile_reset_domain_tile/gemmini/spad/*muladder*] != ""} {
    ungroup -verbose [get_db hinsts system/tile_prci_domain/tile_reset_domain_tile/gemmini/spad/*muladder*]
}
''')
    return True

def syn_opt(x: HammerTool) -> bool:
    x.append('''
puts "syn_opt"
syn_opt
''')
    return True

class ExampleDriver(CLIDriver):
    def get_extra_synthesis_hooks(self) -> List[HammerToolHookAction]:
        extra_hooks = [
            HammerTool.make_pre_insertion_hook("syn_generic", syn_ungroup),
            HammerTool.make_post_insertion_hook("syn_map", syn_opt)
        ]
        return extra_hooks

    def get_extra_par_hooks(self) -> List[HammerToolHookAction]:
        extra_hooks = [
            # Default set of steps can be found in the CAD tool plugin's __init__.py

            # make_pre_insertion_hook will execute the custom hook before the specified step
            # SYNTAX: make_pre_insertion_hook("EXISTING_STEP", INSERTED_HOOK)

            # make_post_insertion_hook will execute the custom hook after the specified step
            # HammerTool.make_post_insertion_hook("init_design", example_tool_settings),

            # make_replacement_hook will replace the specified step with a custom hook
            # HammerTool.make_replacement_hook("place_tap_cells", example_place_tap_cells),

            # make_removal_hook will remove the specified step from the flow
            HammerTool.make_removal_hook("place_bumps"),

            # The target step in any of the above calls may be a default step or another one of your custom hooks
        ]
        return extra_hooks

if __name__ == '__main__':
    ExampleDriver().main()
