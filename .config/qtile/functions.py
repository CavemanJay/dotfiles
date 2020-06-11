import os
from notify import notification


def get_current_wallpaper_folder():
    folder = os.popen(
        f'basename \"$(cat {os.path.expanduser("~/scripts/wallpaper/current")})\"').read()
    folder = folder.replace('\n', '')
    return folder


def wallpaper_folder_clicked(qtile):
    pass


if __name__ == "__main__":
    notification('body', "title")
