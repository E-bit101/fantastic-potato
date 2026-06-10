import os
import pwd
import shutil

SOURCE_DIR = "/configs"

for user in pwd.getpwall():
    if user.pw_uid < 1000:
        continue

    home = user.pw_dir

    if not os.path.isdir(home):
        continue

    config_dir = os.path.join(home, ".config")
    os.makedirs(config_dir, exist_ok=True)

    for item in os.listdir(SOURCE_DIR):
        src = os.path.join(SOURCE_DIR, item)
        dst = os.path.join(config_dir, item)

        if os.path.isdir(src):
            shutil.copytree(src, dst, dirs_exist_ok=True)
        else:
            shutil.copy2(src, dst)

    # Fix ownership
    for root, dirs, files in os.walk(config_dir):
        for name in dirs:
            os.chown(
                os.path.join(root, name),
                user.pw_uid,
                user.pw_gid
            )

        for name in files:
            os.chown(
                os.path.join(root, name),
                user.pw_uid,
                user.pw_gid
            )

    with open("/etc/sddm.conf.d/theme.conf", "w") as f:
        f.write(
"""[Theme]
Current=astronaut-theme"""
        )