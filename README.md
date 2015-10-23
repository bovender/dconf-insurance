# dconf-insurance
Backup and restore the dconf user database on Debian/Ubuntu.

This is a little shell script that serves to automatically backup the dconf
user database upon login, and restore the most recent backup if needed.

The dconf user database, which typically resides in `~/.config/dconf/user` on
Ubuntu systems, is a binary file for performance reasons. Unfortunately, at
least on my computer, every now and then this file gets corrupted, and when I
log into Unity, I stare at the background image, but there is no Unity, no
launcher panel, no indicator panel. Restoring a backup copy of the `user`
database will solve the problem (upon next login).

This script saves copies of `user` in the same directory by appending a suffix
`.backup-` and a time stamp. Backup files older than 30 days will be
automatically deleted.


## Installation

After cloning the repository, add a symbolic link to the `.desktop` file to
your autostart directory; use the included convenience script
`setup-autostart.sh` to do that.

Keep in mind that this will only backup the database when you log into the
Unity desktop!

You may want to add an [anacron][] job that is executed daily. System-wide
anacron jobs are not really suitable because you want to execute the script as
user, not as root. Therefore I recommend to set up a personal anacron service;
you can use the included script `setup-anacron.sh` to do that.


## Contact

If you want to improve this script, you are welcome to fork it and send me a
pull request with your amendments.

If you just want to contact me, e-mail me at bovender `at` bovender `dot` de.

[anacron]: https://en.wikipedia.org/wiki/Anacron
