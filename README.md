NANOHAT
=======

NANOHAT for the NanoPi DUO/NEO/NEO2/NEOPLUS2: an open source platform for connecting BakeBit Sensors & NANOHATHUB / NANOHATOLED / NANOHATMOTOR.


## License

The MIT License (MIT)

NANOHAT for the NanoPi DUO/NEO/NEO2/NEOPLUS2: an open source platform for connecting BakeBit Sensors & NANOHATHUB / NANOHATOLED / NANOHATMOTOR.
Copyright (C) 2017 FriendlyARM / Richard Neese <r.neese@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Scripted Install
================
Grab the script from install-script dir and chmod it +x and ./filename

This will do a complete install of all parts of NANOHAT.


ManualInstall
=============
step 1) git clone https://github.com/RichNeese/NanoHats.git /usr/src/NanoHats

Step 2) cd /usr/src/NanoHats/src

Step 3) mkdir build

Step 4) cd build

Step 5) Replace "OPTIONS" with any of the following:

For OledHat : -DWITH_OLED_SYSTEMD=ON -DWITH_OLED_DAEMON=ON -DWITH_OLEDHAT=ON 

For MotorHat : -DWITH_MOTORHAT=ON

for HubHat : -DWITH_HUBHAT=ON

Step 5.1) cmake -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var "OPTIONS" -Wno-dev .. 

Step 6) make

Step 7) make install

All Code but the systemd files and daemon files will be located in /usr/share/nanohat.