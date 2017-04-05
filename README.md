# buildOpenCVTX2
Build and install OpenCV for the NVIDIA Jetson TX2

These scripts build OpenCV version 3.2 for the Jetson TX2.

JetPack gives the option of installing OpenCV4Tegra (OpenCV 2.4) with accelerated CPU functions. There are several common packages that have issue with this installation, so here's a recipe for building a OpenCV from source.

OpenCV is a rich environment which can be configured in many different ways. You should configure OpenCV for your needs, by modifying the build file "buildOpenCV.sh". Note that selecting different options in OpenCV may also have additional library requirements which are not included in these scripts.

To run the the build file

$ ./buildOpenCV.sh

The build system has been known at times to have issues. It's worth doing a sanity check after the build is complete:

$ cd $HOME/opencv/build

$ make

This should ensure that everything has been built.

After this, you can install the new build:

$ cd $HOME/opencv/build

$ sudo make install

Notes:
There are issues if have both OpenCV4Tegra and a regular OpenCV build installed at the same time. Most people do not install OpenCV4Tegra on their machine if using the OpenCV build.

The Jetson is an aarch64 machine, which means that the OpenCV configuration variable ENABLE_NEON is ignored. The compiler includes NEON support for all machines with aarch64 architecture.

When running the OpenCV tests, currently several of the tests fail.  

References:

Most of this information is derived from:

http://docs.opencv.org/3.2.0/d6/d15/tutorial_building_tegra_cuda.html

https://devtalk.nvidia.com/default/topic/965134/opencv-3-1-compilation-on-tx1-lets-collect-the-quot-definitive-quot-cmake-settings-/?offset=3


 
