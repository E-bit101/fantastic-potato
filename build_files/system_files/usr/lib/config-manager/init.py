import pwd, os
from pathlib import Path

for user in pwd.getpwall():
    # Skip system users
    if user.pw_uid < 1000:
        continue

    home = Path(user.pw_dir)

    if not home.exists():
        continue

    target = home / ".test"

    if not target.exists():
        target.write_text("hello\n")

    os.chown(target, user.pw_uid, user.pw_gid)