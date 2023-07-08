#!/bin/bash

LINUX_REPO="https://github.com/torvalds/linux.git"
MAKE_OLD_CONF="make oldconfig"
MAKE_BINDEB_PKG="make -j $(nproc) bindeb-pkg"

echo "Calling \"sudo apt build-dep linux\" to install necisary build dependencies."
sudo apt update && sudo apt build-dep linux

# Create debs directory is it is not present.
if [ ! -d debs ]
then
	mkdir debs
fi

echo "Compiling upstream kernel and building deb packages."
echo "This will take a minute (i.e like an hour)."
# If linux directory is not present, clone repo.
if [ ! -d "linux" ]
then
	echo "linux directory not found, cloning from $LINUX_REPO."
	git clone $LINUX_REPO
else
	./clean.sh
fi

cd linux
echo "Updating cloned repository"
git pull
echo "Copying $(uname -r) config file to ./linux/.config"
cp /boot/config-$(uname -r) .config
echo "Calling \"$MAKE_OLD_CONF\" to udjust ./linux/.config to new kernel."
$MAKE_OLD_CONF
echo "Calling $MAKE_BINDEB_PKG to "
$MAKE_BINDEB_PKG
cd ..
mv *6* ./debs/
echo "deb packages can be found in debs directory"
