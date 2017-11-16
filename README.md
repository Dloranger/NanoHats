BakeBit
=======

BakeBit for the NanoPi NEO: an open source platform for connecting BakeBit Sensors to the NanoPi NEO.


## License

The MIT License (MIT)

BakeBit for the NanoPi NEO: an open source platform for connecting BakeBit Sensors to the NanoPi NEO.
Copyright (C) 2016 FriendlyARM

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

Install
=======

step 1) git clone https://github.com/RichNeese/NanoHats.git /usr/src/NanoHats

Step 2) cd /usr/src/NanoHats/src

Step 3) mkdir build

Step 4) cd build

Step 5) Replace "OPTIONS" with any of the following:

For OledHat : -DWITH_OLED_SYSTEMD=ON -DWITH_OLED_DAEMON=ON -DWITH_HATOLED=ON 

For MotorHat : -DWITH_HATMOTOR=ON

for HatHub : -DWITH_HATHUB=ON 
Step 5.1) cmake -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var "OPTIONS" -Wno-dev .. 

Step 6) make

Step 7) make install

All Code but the systemd files and daemon files will be located in /usr/share/nanohat.