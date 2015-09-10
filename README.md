epi3lock (i3lock fork) - improved screen locker for EPITA
=========================================================
epi3lock is a simple screen locker for on i3lock. After starting it, you will
see a black screen (you can configure the color/an image), time since the user
are locked, current time, login of user and number of failed attemps.
You can return to your screen by entering your password.

Many little improvements have been made to i3lock over time:

- i3lock forks, so you can combine it with an alias to suspend to RAM
  (run "i3lock && echo mem > /sys/power/state" to get a locked screen
   after waking up your computer from suspend to RAM)

- You can specify either a background color or a PNG image which will be
  displayed while your screen is locked.

- You can specify whether i3lock should bell upon a wrong password.

- i3lock uses PAM and therefore is compatible with LDAP etc.

Requirements
------------
- pkg-config
- libxcb
- libxcb-util
- libpam-dev
- libcairo-dev
- libxcb-xinerama
- libev
- libx11-dev
- libx11-xcb-dev
- libxkbfile-dev
- libxkbcommon >= 0.5.0
- libxkbcommon-x11 >= 0.5.0

Running i3lock
-------------
Simply invoke the 'epi3lock' command. To get out of it, enter your password and
press enter.

Know bugs
---------
Currently, timer needs to be refresh with a pressed-key.

Contributors
------------
- Guillaume Dupuis (EPITA - ACU 2016)
