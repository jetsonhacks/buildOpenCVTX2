#!/bin/bash
# Jetson TX2
ARCH_BIN=6.2
OPENCV_VERSION=3.4.1
PACKAGE_RELEASE=`date +%Y%m%d`

cd $HOME/opencv

cd build
# Jetson TX2 
sudo checkinstall --default \
  --type debian \
  --pkgname opencv \
  --pkgversion "$OPENCV_VERSION" \
  --arch "arm64" \
  --pkgrelease "$PACKAGE_RELEASE" \
  --pkglicense "bsd" \
  --maintainer "jetsonhacks" \
  --requires "" \
  --provides "OpenCV version ${OPENCV_VERSION}" \
  --addso \
  --autodoinst \
  
# 
#  --deldoc --deldesc --delspec \
   

