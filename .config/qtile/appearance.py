import os
import socket

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import bar, widget, hook


##### PROMPT #####
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())


def init_widgets_list():
    widgets_list = [
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
        # widget.TextBox(
        #     # text='',
        #     background=colors[0],
        #     foreground=colors[4],
        #     padding=0,
        #     fontsize=37
        # ),
        # widget.TextBox(
        #     # text='',
        #     background=colors[4],
        #     foreground=colors[5],
        #     padding=0,
        #     fontsize=37
        # ),
        widget.TextBox(
            text=" 🌡",
            padding=2,
            foreground=colors[2],
            background=colors[5],
            fontsize=25
        ),
        widget.ThermalSensor(
            foreground=colors[2],
            background=colors[5],
            padding=5
        ),
        widget.TextBox(
            # text='',
            background=colors[5],
            foreground=colors[4],
            padding=0,
            fontsize=37
        ),
        widget.TextBox(
            text=" ⟳",
            padding=2,
            foreground=colors[2],
            background=colors[4],
            fontsize=30
        ),
        widget.Pacman(
            execute="alacritty",
            update_interval=1800,
            foreground=colors[2],
            background=colors[4]
        ),
        widget.TextBox(
            text="Updates",
            padding=5,
            foreground=colors[2],
            background=colors[4]
        ),
        widget.TextBox(
            # text='',
            background=colors[4],
            foreground=colors[5],
            padding=0,
            fontsize=37
        ),
        widget.TextBox(
            text=" 🖬",
            foreground=colors[2],
            background=colors[5],
            padding=0,
            fontsize=30
        ),
        widget.Memory(
            foreground=colors[2],
            background=colors[5],
            padding=5
        ),
        widget.TextBox(
            # text='',
            background=colors[5],
            foreground=colors[4],
            padding=0,
            fontsize=37
        ),
        widget.Net(
            interface="wlp59s0",
            format='{down} ↓↑ {up}',
            foreground=colors[2],
            background=colors[4],
            padding=5
        ),
        widget.TextBox(
            # text='',
            background=colors[4],
            foreground=colors[5],
            padding=0,
            fontsize=37
        ),
        widget.TextBox(
            text=" Vol:",
            foreground=colors[2],
            background=colors[5],
            padding=0
        ),
        widget.Volume(
            foreground=colors[2],
            background=colors[5],
            padding=5
        ),
        widget.TextBox(
            # text='',
            background=colors[5],
            foreground=colors[4],
            padding=0,
            fontsize=37
        ),
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
        widget.TextBox(
            # text='',
            background=colors[4],
            foreground=colors[5],
            padding=0,
            fontsize=37
        ),
        widget.Clock(
            foreground=colors[2],
            background=colors[5],
            format="%A, %B %d  [ %H:%M ]"
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=colors[0],
            background=colors[5]
        ),
        widget.Systray(
            background=colors[0],
            padding=10,
            icon_size=40
        ),
    ]
    return widgets_list


##### COLORS #####
colors = [["#282a36", "#282a36"],  # panel background
          ["#434758", "#434758"],  # background for current screen tab
          ["#ffffff", "#ffffff"],  # font color for group names
          ["#ff5555", "#ff5555"],  # border line color for current tab
          ["#8d62a9", "#8d62a9"],  # border line color for other tab and odd widgets
          ["#668bd7", "#668bd7"],  # color for the even widgets
          ["#e1acff", "#e1acff"]]  # window name


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
    Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=0.85, size=55))
]
