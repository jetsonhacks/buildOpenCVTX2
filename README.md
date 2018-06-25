# buildOpenCVTX2
Build and install OpenCV for the NVIDIA Jetson TX2

These scripts build OpenCV version 3.4 for the NVIDIA Jetson TX2 Development Kit. Please see Releases/Tags for earlier versions.

OpenCV is a rich environment which can be configured in many different ways. You should configure OpenCV for your needs, by modifying the build file "buildOpenCV.sh". Note that selecting different options in OpenCV may also have additional library requirements which are not included in these scripts. Please read the notes below for other important points before installing.

The buildOpenCV script has two optional command line parameters:

<ul>
<li>-s | --sourcedir   Directory in which to place the opencv sources (default $HOME)</li>
<li>-i | --installdir  Directory in which to install opencv libraries (default /usr/local)</li>
</ul>

To run the the build file:

$ ./buildOpenCV.sh -s &lt;file directory&gt;

This example will build OpenCV in the given file directory and install OpenCV in the /usr/local directory.

The folder ~/opencv and (optional) ~/opencv_extras contain the source, build and extra data files. If you wish to remove them after installation, a convenience script is provided:

$ ./removeOpenCVSources.sh -d &lt;file directory&gt;

where the &lt;file directory&gt; contains the OpenCV source.

The folder ~/opencv and ~/opencv_extras contain the source, build and extra data files. If you wish to remove them after installation, a convenience script is provided:

$ ./removeOpenCVSources.sh

<h3>Packaging</h3>
An alternative build script, buildAndPackageOpenCV.sh , will build the OpenCV package as described above and the build .deb files using the standard OpenCV mechanism defined using the CPACK_BINARY_DEB=ON in the OpenCV Make file. See the script.

The buildAndPackageOpenCV script has two optional command line parameters:

<ul>
<li>-s | --sourcedir   Directory in which to place the opencv sources (default $HOME)</li>
<li>-i | --installdir  Directory in which to install opencv libraries (default /usr/local)</li>
</ul>

To run the the build file:

$ ./buildAndPackageOpenCV.sh -s &lt;file directory&gt;

This example will build OpenCV in the given file directory and install OpenCV in the /usr/local directory.

The corresponding .deb files will be in the &lt;file directory&gt;/opencv/build directory in .deb file and compressed forms. 

<h4>Installing .deb files</h4>

To install .deb files:

Switch to the directory where the .deb files are located. Then:

<blockquote>
$ sudo dpkg -i OpenCV-&lt;OpenCV Version info&gt;-aarch64-libs.deb

<em>For example: $ sudo dpkg -i OpenCV-3.4.1-1-g75a2577-aarch64-libs.deb</em> 

$ sudo apt-get install -f

$ sudo dpkg -i OpenCV-&lt;OpenCV Version info&gt;-aarch64-dev.deb 

$ sudo dpkg -i OpenCV-&lt;OpenCV Version info&gt;-aarch64-python.deb </blockquote>

The libraries will be installed in /usr/lib

Binaries are in /usr/bin

opencv.pc is in /usr/lib/pkgconfig

<strong>Package Notes: </strong>
<ul><li>The build process default installation is in /usr/local
Note that the .deb file install into /usr</li>
<li>After installation, the dpkg/apt name does not include version information, e.g. the name is opencv-libs</li>
</ul>

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
June 2018
* L4T 28.2
* CUDA 9
* OpenCV 3.4
* Added command line arguments to set source and installation directories
* Add a script to build OpenCV .deb packages.
* Add upstream patch for C library compilation issues

May 2018
* L4T 28.2
* CUDA 9
* OpenCV 3.4
* OpenGL support added to build script
* Fast Math support (cuBLAS) added
* Supports both Python 2 and Python 3
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
 
