import os
from libqtile.command import lazy
from notify import notification
from libqtile import hook
import psutil


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i-1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def get_current_wallpaper_folder():
    folder = os.popen(
        f'basename \"$(cat {os.path.expanduser("~/scripts/wallpaper/current")})\"').read()
    folder = folder.replace('\n', '')
    return folder


def get_disk_usage():
    usage = os.popen(
        "df -h | grep /nvm | head -n 1 | awk 'OFS=\"/\"{print $3,$2}' | sed s/G/GB/g").read()
    usage = usage.replace('\n', '')
    return usage


def wallpaper_folder_clicked(qtile):
    pass

# Window swallowing
# @hook.subscribe.client_new
# def _swallow(window):
#     pid = window.window.get_net_wm_pid()
#     ppid = psutil.Process(pid).ppid()
#     cpids = {c.window.get_net_wm_pid(): wid for wid,
#              c in window.qtile.windows_map.items()}
#     for i in range(5):
#         if not ppid:
#             return
#         if ppid in cpids:
#             parent = window.qtile.windows_map.get(cpids[ppid])
#             parent.minimized = True
#             window.parent = parent
#             return
#         ppid = psutil.Process(ppid).ppid()


# @hook.subscribe.client_killed
# def _unswallow(window):
#     if hasattr(window, 'parent'):
#         window.parent.minimized = False

# terminal command to get disk use:

if __name__ == "__main__":
    # print(get_disk_usage())
    pass
