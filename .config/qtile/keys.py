from libqtile.config import Key
from libqtile.lazy import lazy

mod = "mod4"
alt = "mod1"

browser = "qutebrowser"
terminal = "alacritty"


def _application_keys():
    return [
        Key([mod], "x", lazy.spawn(terminal),
            desc='Spawn a terminal'),
        Key([alt], "space", lazy.spawn("dmenu_run -p 'Run: '"),
            desc='Show a dmenu run prompt'),
        Key([mod], "b", lazy.spawn(browser),
            desc='Spawn a browser'),
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
        Key([mod], "k", lazy.layout.down()),
        Key([mod], "j", lazy.layout.up()),

        # Move windows up or down in current stack
        Key([mod, "control"], "k", lazy.layout.shuffle_down()),
        Key([mod, "control"], "j", lazy.layout.shuffle_up()),
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
            [alt, "control"], "m",
            lazy.spawn("clipmenu -c"),
            desc='Clipboard script'
        ),
        Key(
            [alt, "control"], "s",
            lazy.spawn("./scripts/wallpaper/safe_wallpaper.sh"),
            desc='Dmenu wallpaper script'
        )
    ]


keys = _application_keys() + _window_keys() + _misc_keys() + \
    _script_keys() + _layout_keys()