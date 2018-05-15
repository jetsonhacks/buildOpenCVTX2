#!/bin/bash
# License: MIT. See license file in root directory
# Copyright(c) JetsonHacks (2017-2018)

# Experimental; Builds a cheat .deb file in the ~/package_build directory
#
OPENCV_VERSION=3.4.1
# Jetson TX2
ARCH_BIN=6.2
# Jetson TX1
# ARCH_BIN=5.3
MAINTAINER="maintainer <maintainer@maintainer.com>"
# Builds packages in the directory ~/package_build


# Repository setup
sudo apt-add-repository universe
sudo apt-get update

cd $HOME
sudo apt-get install -y \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libeigen3-dev \
    libglew-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    libjasper-dev \
    libjpeg-dev \
    libpng12-dev \
    libpostproc-dev \
    libswscale-dev \
    libtbb-dev \
    libtiff5-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    qt5-default \
    zlib1g-dev \
    cmake \
    pkg-config

# https://devtalk.nvidia.com/default/topic/1007290/jetson-tx2/building-opencv-with-opengl-support-/post/5141945/#5141945
cd /usr/local/cuda/include
sudo patch -N cuda_gl_interop.h '/home/nvidia/buildOpenCVTX2/patches/OpenGLHeader.patch' 
# Clean up the OpenGL tegra libs that usually get crushed
cd /usr/lib/aarch64-linux-gnu/
sudo ln -sf tegra/libGL.so libGL.so


cd $HOME

# Python 2.7
sudo apt-get install -y python-dev python-numpy python-py python-pytest
# Python 3.5
sudo apt-get install -y python3-dev python3-numpy python3-py python3-pytest


# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout -b v${OPENCV_VERSION} ${OPENCV_VERSION}
if [ $OPENCV_VERSION = 3.4.1 ] ; then
  # For 3.4.1, use this commit to fix samples/gpu/CMakeLists.txt
  git merge ec0bb66e5e176ffe267948a98508ac6721daf8ad
fi


# This is for the test data
cd $HOME
git clone https://github.com/opencv/opencv_extra.git
cd opencv_extra
git checkout -b v${OPENCV_VERSION} ${OPENCV_VERSION}

cd $HOME/opencv
mkdir build
cd build
# Jetson TX2 

time cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=~/package_build/opencv-3.4.1/usr/local \
      -D WITH_CUDA=ON \
      -D CUDA_ARCH_BIN=${ARCH_BIN} \
      -D CUDA_ARCH_PTX="" \
      -D ENABLE_FAST_MATH=ON \
      -D CUDA_FAST_MATH=ON \
      -D WITH_CUBLAS=ON \
      -D WITH_LIBV4L=ON \
      -D WITH_GSTREAMER=ON \
      -D WITH_GSTREAMER_0_10=OFF \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D INSTALL_TESTS=ON \
      -D OPENCV_TEST_DATA_PATH=../opencv_extra/testdata \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      ../

if [ $? -eq 0 ] ; then
  echo "CMake configuration make successful"
else
  # Try to make again
  echo "CMake issues " >&2
  echo "Please check the configuration being used"
  exit 1
fi

# Consider $ sudo nvpmodel -m 2 or $ sudo nvpmodel -m 0
NUM_CPU=$(nproc)
time make -j$(($NUM_CPU - 1))
if [ $? -eq 0 ] ; then
  echo "OpenCV make successful"
else
  # Try to make again; Sometimes there are issues with the build
  # because of lack of resources or concurrency issues
  echo "Make did not build " >&2
  echo "Retrying ... "
  # Single thread this time
  make
  if [ $? -eq 0 ] ; then
    echo "OpenCV make successful"
  else
    # Try to make again
    echo "Make did not successfully build" >&2
    exit 1
  fi
fi

exit

echo "Installing ... "
make install

# Preparing to package
mkdir -p ~/package_build/opencv-$OPENCV_VERSION/etc/ld.so.conf.d
echo "~/package_build/opencv-${OPENCV_VERSION}/usr/local/lib" > ~/package_build/opencv-$OPENCV_VERSION/etc/ld.so.conf.d/opencv.conf

mkdir -p ~/package_build/opencv-$OPENCV_VERSION/DEBIAN \
&& cd ~/package_build \
&& echo -e "Source: opencv-${OPENCV_VERSION}\n\
Package: opencv\n\
Version: ${OPENCV_VERSION}\n\
Priority: optional\n\
Maintainer: $MAINTAINER\n\
Architecture: arm64\n\
Depends: \n\
Description: OpenCV version $OPENCV_VERSION\n"\
> ~/package_build/$OPENCV_VERSION/DEBIAN/control
echo "Packagin with dpkg-deb"
time fakeroot dpkg-deb --build opencv-$OPENCV_VERSION
echo "OpenCV package .deb built."
echo "Pakcage is in ~/package_build/opencv-${OPENCV_VERSION}.deb"
