# buildOpenCVTX2
Build and install OpenCV for the NVIDIA Jetson TX2

These scripts build OpenCV version 3.4 for the NVIDIA Jetson TX2 Development Kit. Please see Releases/Tags for earlier versions.

OpenCV is a rich environment which can be configured in many different ways. You should configure OpenCV for your needs, by modifying the build file "buildOpenCV.sh". Note that selecting different options in OpenCV may also have additional library requirements which are not included in these scripts. Please read the notes below for other important points before installing.

To run the the build file:

$ ./buildOpenCV.sh

This will build and install OpenCV is the /usr/local directory.

The folder ~/opencv and ~/opencv_extras contain the source, build and extra data files. If you wish to remove them after installation, a convenience script is provided:

$ ./removeOpenCVSources.sh

## Notes
There may be issues if different version of OpenCV are installed. JetPack normally installs OpenCV in the /usr folder. You will need to consider if this is appropriate for your application. It is important to realize that many packages may rely on OpenCV. The standard installation by JetPack places the OpenCV libraries in the /usr directory. 

You may consider removing OpenCV installed by JetPack before performing this script installation:

$ sudo apt-get purge libopencv*

With this script release, the script now installs OpenCV in /usr/local. Earlier versions of this script installed in /usr. You may have to set your include and libraries and/or PYTHONPATH to point to the new version. See the Examples folder. Alternatively, you may want to change the script to install into the /usr directory.

The Jetson is an aarch64 machine, which means that the OpenCV configuration variable ENABLE_NEON is ignored. The compiler includes NEON support for all machines with aarch64 architecture.

These scripts rely on OpenCV finding the correct CUDA version, instead of setting it manually.

Special thanks to Daniel (Github user @dkoguciuk) for script cleanup.


## References

Most of this information is derived from:

http://docs.opencv.org/3.2.0/d6/d15/tutorial_building_tegra_cuda.html

https://devtalk.nvidia.com/default/topic/965134/opencv-3-1-compilation-on-tx1-lets-collect-the-quot-definitive-quot-cmake-settings-/?offset=3

## Release Notes
May 2018
* L4T 28.2
* CUDA 9
* OpenCV 3.4
* OpenGL support added to build script
* Fast Math support (cuBLAS) added
* Supports both Python 3 and Python 2
* Canny Detection example supports built-in camera and USB camera. See the Examples folder

September 2017
* L4T 28.1
* CUDA 8
* OpenCV 3.3
* GStreamer support added to build script
* GStreamer OpenCV examples using the Jetson onboard camera 

April 2017
* Initial Release
* L4T 27.1
* OpenCV 3.2

## License
MIT License

Copyright (c) 2017-2018 Jetsonhacks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 
