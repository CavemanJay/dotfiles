import os
import subprocess
import socket

from keys import keys, mod, alt
from layouts import *
from appearance import *

from libqtile.config import Key, Screen, Group, Drag, Click, Match, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile import bar, widget, hook

from typing import List  # noqa: F401

##### GROUPS #####

groups = [
    Group("WWW"),
    Group("CODE"),
    Group("SYS"),
    Group("VBOX"),
    Group("MUS"),
    Group("MISC"),
    ScratchPad("scratchpad", [
        DropDown('term', 'alacritty', y=0.05, height=0.85),
        DropDown('cmus', 'alacritty -e cmus', y=0.1, height=0.85),
    ])]

# groups = [Group(i) for i in "abc"]
# groups = [Group(name) for name in group_names]

for i, group in enumerate(groups, 1):
    keys.extend([
        # Switch to another group
        Key([mod], str(i), lazy.group[group.name].toscreen()),
        # Send current window to another group
        Key([mod, "shift"], str(i), lazy.window.togroup(
            group.name), switch_group=False)

        # mod1 + letter of group = switch to group
        # Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(
        #     i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])


dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"

##### STARTUP APPLICATIONS #####


@ hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
