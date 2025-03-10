#!/bin/bash

#
# Copyright © 2017, Rohan Taneja @ xda-developers
#
# This is a build script for building Daredevil Kernel builds
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
#

clear

VAR="DevP#"
BUILD_DATE=$(date +"%Y%m%d")
TREE=$PWD
AK="$TREE/AnyKernel2_hybrid"
IMAGE=$TREE/arch/arm64/boot/Image.gz-dtb
OUTPUTDIR=$TREE/output

# shell script colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
defcol='\033[0m'

# fixed settings
export ARCH=arm64
export SUBARCH=arm64
export CONFIG_NO_ERROR_ON_MISMATCH=y
export CROSS_COMPILE=aarch64-linux-android-
JOBS=-j$($(nproc) + 1)

# Make changes as per the user
export PATH=/media/tanish2k09/Tanish/Tanish/compiling/aarch64-linux-android-6.x/bin:$PATH
export KBUILD_BUILD_USER="tanish2k09"
export KBUILD_BUILD_HOST="MTKILLER"
DEVICE="aio_row"
CONFIG="daredevil_defconfig"

#export CONFIG_DEBUG_SECTION_MISMATCH=y

# Function declaration
dd_clean() {
                cd $AK
                rm -rf Image.gz-dtb
                cd ..
                make clean mrproper
                rm -rf $OUTPUTDIR/*
                   }

dd_compile() {
                echo "$red *******************************"
                echo "$green*    Compilation in Progress    *"
                echo "$blue *******************************$defcol"
                BUILD_BEGIN=$(date +"%s")
                make $CONFIG
                make $JOBS -w
                BUILD_TIME=$(date +"%H%M")
                if ![ -e "$IMAGE" ]; then
                echo "$red Error 404: Kernel not compiled."
                echo "Fix the compilation errors! $defcol"
                exit 1; fi;
                BUILD_END=$(date +"%s")
                DIFF=$(($BUILD_END - $BUILD_BEGIN))
                echo "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
                cp -i $IMAGE $AK/kernel_files/Image.gz-dtbN
                    }

dd_zip() {
                cd $AK
                BUILD_TIME=$(date +"%H%M")
                zip -r Venom-Hybrid-$VAR-$BUILD_DATE-$BUILD_TIME-$DEVICE.zip *
                if ! [ -d "$OUTPUTDIR" ]; then
                mkdir $OUTPUTDIR
                fi;
                mv Venom-Hybrid-*.zip $OUTPUTDIR
                cd $TREE
                }

# Script Menu

while true;

clear

echo "$red                Welcome$green to$blue Daredevil$yellow Build Script$defcol"
echo "Make a choice to proceed further"
echo "$red(1) Clean kernel source tree"
echo "$green(2) Compile VENOM-S build"
echo "$blue(3) Generate Flashable Zip"
echo "$yellow(4) Exit the script$defcol"

read -p "Enter your choice (1-4):" ch

do
case "$ch" in
1) dd_clean
;;
2) dd_compile
;;
3) dd_zip
;;
4) exit 1
;;
esac
done
