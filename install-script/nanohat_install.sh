#! /bin/bash
echo "Welcome to BakeBit Installer."
echo " "
echo "Requirements:"
echo "1) Must be connected to the internet"
echo "2) This script must be run as root user"
echo " "
echo "Steps:"
echo "Installs package dependencies:"
echo "   - cmake            cmake scripts and deps for pkg build and install"
echo "   - libi2c-dev       userspace I2C programming library development files"
echo "   - libfreetype6-dev static library, headers to develop your own programs using the FreeType 2 library"
echo "   - libjpeg-dev      Development files for the libjpeg-turbo JPEG library"
echo "   - i2c-tools        This Python module allows SMBus access through the I2C /dev"
echo "   - git              fast, scalable, distributed revision control system"
echo "   - minicom          friendly menu driven serial communication program"
echo "   - python2.7        python2.7"
echo "   - python-dev       Header files, a static library and development tools for building Python modules"
echo "   - python-pip       alternative Python package installer"
echo "   - python-setuptools library designed to facilitate packaging Python projects"
echo "   - python-serial    pyserial - module encapsulating access for the serial port"
echo "   - python-smbus     Python bindings for Linux SMBus access through i2c-dev"
echo "   - python-psutil    a cross-platform process and system utilities module for Python"
echo "   - python image     adds image processing capabilities to your Python interprete(PIP)"
echo "   - python pillow    libraries for image manipulation in Python(Friendly Fork)(PIP)"
echo "   - RPi.GPIO			A module to control Raspberry Pi GPIO channels"
echo "   - WiringNP         a GPIO access library for NanoPi NEO"
echo " "
sleep 5

apt-get install wget nano sudo -y

echo " "
echo "Check for internet connectivity..."
echo "=================================="
wget -q --tries=2 --timeout=100 http://www.baidu.com -O /dev/null
if [ $? -eq 0 ];then
	echo "Connected"
else
	echo "Unable to Connect, try again !!!"
	exit 0
fi

USER_ID=$(/usr/bin/id -u)
USER_NAME=$(/usr/bin/who am i | awk '{ print $1 }')

if [ ${USER_ID} -ne 0 ]; then
    echo "Please run this as root."
    exit 1
fi
echo ""
echo " Checking For Updates  "
sudo apt-get update --yes
echo "======================="

echo " "
echo "Installing Dependencies"
echo "======================="
sudo apt-get install gcc -y
sudo apt-get install cmake git libi2c-dev i2c-tools minicom libfreetype6-dev libjpeg-dev avrdude -y
sudo apt-get install python2.7 python-dev python-pip python-setuptools python-serial python-smbus python-psutil -y
yes | sudo pip install wheel image pillow
yes | sudo pip install image
yes | sudo pip install pillow

if [ -d RPi.GPIO-0.6.3 ]; then
	wget http://ftp.us.debian.org/debian/pool/main/r/rpi.gpio/rpi.gpio-common_0.6.3-1+b1_armhf.deb
	wget http://ftp.us.debian.org/debian/pool/main/r/rpi.gpio/python-rpi.gpio_0.6.3-1+b1_armhf.deb
    dpkg -i rpi.gpio-common_0.6.3-1+b1_armhf.deb
	dpkg -i python-rpi.gpio_0.6.3-1+b1_armhf.deb
	rm rpi.gpio-common_0.6.3-1+b1_armhf.deb python-rpi.gpio_0.6.3-1+b1_armhf.deb
fi

echo "Dependencies installed"

sudo adduser ${USER_NAME} i2c

cd /usr/src
sudo git clone https://github.com/friendlyarm/WiringNP.git
cd WiringNP
sudo ./build
RES=$?
if [ $RES -ne 0 ]; then
  echo "Something went wrong building/installing WiringNP, exiting."
  exit 1
fi
echo "WiringNP Installed"

sudo adduser ${USER_NAME} i2c

#clone repo and install
git clone https://github.com/RichNeese/NanoHats.git /usr/src/NanoHats
cd /usr/src/NanoHats/src
sudo mkdir build
cd build
sudo cmake -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_OLED_SYSTEMD=ON -DWITH_OLED_DAEMON=ON -DWITH_OLEDHAT=ON -DWITH_MOTORHAT=ON -DWITH_HUBHAT=ON -Wno-dev .. 
sudo make
sudo make install

echo " "
echo " If using armbin do the following"
echo " armbian-config > System > Hardware"
echo " select the following modules :"
echo " i2c0 i2c1 spi-spidev usbhost1 usbhost2"
echo " Warning: do not enable uart2. Its is"
echo " used for the 3 buttons on the oled screen"
echo " save > exit menu"
echo " "

echo " "
echo "Please restart to implement changes!"
echo "  _____  ______  _____ _______       _____ _______ "
echo " |  __ \|  ____|/ ____|__   __|/\   |  __ \__   __|"
echo " | |__) | |__  | (___    | |  /  \  | |__) | | |   "
echo " |  _  /|  __|  \___ \   | | / /\ \ |  _  /  | |   "
echo " | | \ \| |____ ____) |  | |/ ____ \| | \ \  | |   "
echo " |_|  \_\______|_____/   |_/_/    \_\_|  \_\ |_|   "
echo " "
echo "To Restart type sudo reboot"
echo " "
