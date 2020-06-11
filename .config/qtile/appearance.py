import os
import socket

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import bar, widget, hook

import functions

##### PROMPT #####
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())


def init_top_bar_widgets():
    return [
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[2],
            background=colors[0]
        ),
        widget.GroupBox(font="Ubuntu Bold",
                        fontsize=24,
                        margin_y=3,
                        margin_x=0,
                        padding_y=5,
                        padding_x=5,
                        borderwidth=3,
                        active=colors[2],
                        inactive=colors[2],
                        rounded=False,
                        highlight_color=colors[1],
                        highlight_method="line",
                        this_current_screen_border=colors[3],
                        this_screen_border=colors[4],
                        other_current_screen_border=colors[0],
                        other_screen_border=colors[0],
                        foreground=colors[2],
                        background=colors[0]
                        ),
        widget.Prompt(
            prompt=prompt,
            font="Ubuntu Mono",
            padding=10,
            foreground=colors[3],
            background=colors[1]
        ),
        widget.Sep(
            linewidth=0,
            padding=40,
            foreground=colors[2],
            background=colors[0]
        ),
        widget.WindowName(
            foreground=colors[6],
            background=colors[0],
            padding=0
        ),
        widget.TextBox(
            text=" 🌡",
            padding=2,
            foreground=colors[2],
            background=colors[4],
            fontsize=25
        ),
        widget.ThermalSensor(
            foreground=colors[2],
            background=colors[4],
            padding=5
        ),
        widget.TextBox(
            text=" ⟳",
            padding=2,
            foreground=colors[2],
            background=colors[5],
            fontsize=30
        ),
        widget.Pacman(
            execute="alacritty",
            update_interval=60,
            foreground=colors[2],
            background=colors[5]
        ),
        widget.TextBox(
            text="Updates",
            padding=5,
            foreground=colors[2],
            background=colors[5]
        ),
        widget.TextBox(
            text=" 🖬",
            foreground=colors[2],
            background=colors[4],
            padding=0,
            fontsize=30
        ),
        widget.Memory(
            foreground=colors[2],
            background=colors[4],
            padding=5
        ),
        widget.MemoryGraph(
            graph_color="FFFFFF"
        ),
        widget.Sep(
            linewidth=0,
            padding=5
        ),
        widget.CPU(
            foreground=colors[2],
            background=colors[5],
            padding=5
        ),
        widget.CPUGraph(
            background=colors[5],
            # graph_color=colors[5][0],
            graph_color="FFFFFF"
        ),
        widget.Net(
            interface="wlp59s0",
            format='{down} ↓↑ {up}',
            foreground=colors[2],
            background=colors[4],
            padding=5
        ),
        widget.TextBox(
            text='|',
            foreground=colors[2],
            background=colors[4],
            padding=0,
            fontsize=37
        ),
        widget.Wlan(
            interface="wlp59s0",
            format="{essid} {percent:2.0%}",
            foreground=colors[2],
            background=colors[4],
            padding=5
        ),
        widget.NetGraph(
            interface="wlp59s0",
            graph_color="FFFFFF"
        ),
        # widget.Sep(
        #     linewidth=0,
        #     padding=10,
        #     foreground=colors[0],
        #     background=colors[5]
        # ),
        widget.Systray(
            background=colors[3],
            padding=10,
            icon_size=40
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=colors[0],
            background=colors[3]
        )
    ]


def init_bottom_bar_widgets():
    return [
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[0],
            background=colors[4],
            padding=0,
            scale=0.7
        ),
        widget.CurrentLayout(
            foreground=colors[2],
            background=colors[4],
            padding=5
        ),
        widget.GenPollText(
            func=functions.get_current_wallpaper_folder,
            update_interval=20,
            foreground=colors[2],
            background=colors[5],
        ),
        widget.Spacer(),
        widget.Backlight(
            change_command='sudo xbacklight -set {0}',
            backlight_name='intel_backlight',
            foreground=colors[2],
            background=colors[5],
            format='Brightness: {percent: 2.0%}'
        ),
        widget.TextBox(
            text=" Volume:",
            foreground=colors[2],
            background=colors[4],
            padding=0
        ),
        widget.Volume(
            foreground=colors[2],
            background=colors[4],
            padding=5,
        ),
        widget.Battery(
            padding=5,
            foreground=colors[2],
            background=colors[5],
            show_short_text=False,
            charge_char='⚡',
            full_char='',
            discharge_char='↓',
            low_percentage=.2
        ),
        widget.Clock(
            foreground=colors[2],
            background=colors[4],
            format=" %A, %B %d  [ %I:%M %p ]",
            padding=5
        ),
        widget.QuickExit(
            background=colors[5],
            padding=5
        )
    ]


##### COLORS #####
colors = [["#282a36", "#282a36"],  # panel background
          ["#434758", "#434758"],  # background for current screen tab
          ["#ffffff", "#ffffff"],  # font color for group names
          ["#ff5555", "#ff5555"],  # border line color for current tab
          ["#000000", "#000000"],  # border line color for other tab and odd widgets
          ["#ff3333", "#ff3333"],  # color for the even widgets
          ["#e1acff", "#e1acff"]]  # window name

# colors = [["#282a36", "#282a36"],  # panel background
#         ["#434758", "#434758"],  # background for current screen tab
#        ["#ffffff", "#ffffff"],  # font color for group names
#       ["#ff5555", "#ff5555"],  # border line color for current tab
#      ["#8d62a9", "#8d62a9"],  # border line color for other tab and odd widgets
#     ["#668bd7", "#668bd7"],  # color for the even widgets
#    ["#e1acff", "#e1acff"]]  # window name


widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize=30,
    padding=3,
    # background=colors[2]
)
extension_defaults = widget_defaults.copy()

screens = [
    # Screen(
    #     bottom=bar.Bar(
    #         [
    #             widget.CurrentLayout(),
    #             widget.GroupBox(),
    #             widget.Prompt(),
    #             widget.WindowName(),
    #             widget.TextBox("default config", name="default"),
    #             widget.Systray(),
    #             widget.Net(interface='wlp59s0'),
    #             widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
    #             widget.Battery(),
    #             widget.QuickExit(),
    #         ],
    #         24,
    #     ),
    # ),
    Screen(
        top=bar.Bar(widgets=init_top_bar_widgets(), opacity=0.85, size=55),
        bottom=bar.Bar(widgets=init_bottom_bar_widgets(),
                       opacity=0.85, size=65),
    )
]
