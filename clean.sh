#!/bin/bash

echo "Removing packages from previous build, cleaning repo."

MAKE_CLEAN="make clean"
MAKE_MRPROPER="make mrproper"

if [ -d "linux" ]
then
	cd linux
	echo "Calling $MAKE_CLEAN"
	$MAKE_CLEAN
	echo "Calling $MAKE_MRPROPER"
	$MAKE_MRPROPER
	cd ..
fi
