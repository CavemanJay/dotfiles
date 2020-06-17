from libqtile.config import Key, Drag, Click
from libqtile.lazy import lazy
from libqtile.extension import window_list


mod = "mod4"
alt = "mod1"

browser = "qutebrowser"
terminal = "alacritty"


def _application_keys():
    return [
        Key([mod], "x", lazy.spawn(terminal),
            desc='Spawn a terminal'),
        Key([alt], "space", lazy.spawn("j4-dmenu-desktop --dmenu=\"dmenu -i -p 'Launch: '\" --term='alacritty'"),
            desc='Show a dmenu application launcher prompt'),
        Key([alt], "r", lazy.spawn("dmenu_run -i -p 'Run: '"),
            desc='Show a dmenu run prompt'),
        Key([mod], "b", lazy.spawn(browser),
            desc='Spawn a browser'),
        Key([mod], "e", lazy.spawn(f'{terminal} -e ranger'),
            desc='Spawn a file browser'),
    ]


def _window_keys():
    # Keys that pertain to managing a window
    return [
        Key([mod], "f", lazy.window.toggle_fullscreen(),
            desc='Fullscreen current window'),
        Key([mod], "q", lazy.window.kill(),
            desc='Kill active window'),
        Key([mod, "shift"], 'f', lazy.window.toggle_floating(),
            desc='Toggles a window to be floating or not'),
    ]


def _misc_keys():
    return [
        Key([mod, "control"], "r", lazy.restart(),
            desc='Restart qtile'),
        Key([mod, "control"], "q", lazy.shutdown(),
            desc='Shutdown qtile'),
    ]


def _layout_keys():
    # Keys that pertain to managing/navigating/changing layouts
    return [

        # Toggle between different layouts as defined below
        Key([mod], "space", lazy.next_layout(),
            desc='Toggle through available layouts'),

        Key([mod], 'g', lazy.layout.grow(),
            desc='Expand window (MonadTall)'),
        Key([mod], 's', lazy.layout.shrink(),
            desc='Shrink window (MonadTall)'),

        # Switch windows
        Key([alt], "Tab", lazy.layout.next(),
            desc='Toggle through open windows'),

        # Switch between windows in current stack pane
        Key([mod], "j", lazy.layout.down(),
            desc="Move down the windows in current layout"),
        Key([mod], "k", lazy.layout.up(),
            desc="Move up the windows in current layout"),

        # Move windows up or down in current stack
        Key([mod, "control"], "k",
            lazy.layout.shuffle_down()),
        Key([mod, "control"], "j",
            lazy.layout.shuffle_up()),

        Key([mod, "shift"], "k",
            lazy.layout.section_up()),
        Key([mod, "shift"], "j",
            lazy.layout.section_down()),
    ]


def _script_keys():
    # Dmenu scripts launched with ALT + CTRL + KEY
    return [
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
            [alt, "control"], "v",
            lazy.spawn("./scripts/dmenu/dmenu-show-vms.sh"),
            desc='Launch an available virtual machine'
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
        Key(
            [alt, "control"], "space",
            lazy.run_extension(window_list.WindowList(
                dmenu_prompt='Change window: ',
                fontsize=12,
                dmenu_command='dmenu -c -i'
            )),
            desc='Dmenu show active windows and select the chosen one'
        )
    ]


def _scratchpad_keys():
    return [
        Key([mod, 'shift'], 'x', lazy.group['scratchpad'].dropdown_toggle('term')),
        Key([mod, 'shift'], 'c', lazy.group['scratchpad'].dropdown_toggle('cmus'))
    ]


keys = _application_keys() + _window_keys() + _misc_keys() + \
    _script_keys() + _layout_keys() + _scratchpad_keys()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
