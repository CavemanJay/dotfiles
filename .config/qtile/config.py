import os
import subprocess

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

mod = "mod4"
alt = "mod1"
browser = "qutebrowser"
terminal = "alacritty"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch windows
    Key([alt], "Tab", lazy.layout.next(), desc='Toggle through open windows'),

    Key([mod], "f", lazy.window.toggle_fullscreen(),
        desc='Fullscreen current window'),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Spawn terminal
    Key([mod], "x", lazy.spawn(terminal),
        desc='Spawn the terminator terminal emulator'),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(),
        desc='Toggle through available layouts'),
    Key([mod], "q", lazy.window.kill(), desc='Kill active window'),

    Key([mod], 'g', lazy.layout.grow(), desc='Expand window (MonadTall)'),
    Key([mod], 's', lazy.layout.shrink(), desc='Shrink window (MonadTall)'),
    Key([mod, "shift"], 'f', lazy.window.toggle_floating(),
        desc='Shrink window (MonadTall)'),

    Key([mod, "control"], "r", lazy.restart(), desc='Restart qtile'),
    Key([mod, "control"], "q", lazy.shutdown(), desc='Shutdown qtile'),
    Key([alt], "space", lazy.spawn("dmenu_run -p 'Run: '")),

    # Dmenu scripts launched with ALT + CTRL + KEY
    Key(
        [alt, "control"], "e",
        lazy.spawn("./scripts/dmenu/dmenu-edit-configs.sh"),
        desc='Dmenu script for editing config files'
    ),
    Key(
        [alt, "control"], "i",
        lazy.spawn("./scripts/dmenu/dmenu-scrot.sh"),
        desc='Dmenu scrot script'
    ),
    Key(
        [alt, "control"], "w",
        lazy.spawn("./scripts/dmenu/dmenu-set-wallpaper.sh"),
        desc='Dmenu wallpaper script'
    ),
    Key(
        [alt, "control"], "m",
        lazy.spawn("clipmenu -c"),
        desc='Clipboard script'
    ),

    Key(
        [alt, "control"], "s",
        lazy.spawn("./scripts/wallpaper/safe_wallpaper.sh"),
        desc='Dmenu wallpaper script'
    ),
]

groups = [Group(i) for i in "abc"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(
            i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.Floating(),
]

widget_defaults = dict(
    # font='sans',
    font="Ubuntu",
    fontsize=22,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.TextBox("default config", name="default"),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.Battery(),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

##### STARTUP APPLICATIONS #####
@hook.subscribe.startup_once
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
