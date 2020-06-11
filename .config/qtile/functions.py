import os


def get_current_wallpaper_folder():
    folder = os.popen(
        f'basename \"$(cat {os.path.expanduser("~/scripts/wallpaper/current")})\"').read()
    folder = folder.replace('\n', '')
    return folder


if __name__ == "__main__":
    folder = get_current_wallpaper_folder()
    print(folder)
