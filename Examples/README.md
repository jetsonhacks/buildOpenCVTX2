There are two example programs here. Both programs require OpenCV to be installed with GStreamer support enabled.
Both of these examples were last tested with L4T 28.1, OpenCV 3.3

The first is a simple C++ program to view the onboard camera feed from the Jetson Dev Kit.

To compile gstreamer_view.cpp:

$ gcc -std=c++11 gstreamer_view.cpp -o gstreamer_view -L/usr/lib -lstdc++ -lopencv_core -lopencv_highgui -lopencv_videoio

to run the program:

$ ./gstreamer_view

The second is a Python program that reads the onboard camera feed from the Jetson Dev Kit and does Canny Edge Detection.

To run the Canny detection demo:

$ python cannyDetection.py

## Notes
1. OpenCV4Tegra does not have GStreamer support enabled, and therefore will not run these demos
2. The gstreamer_view example is from Peter Moran:
   https://gist.github.com/peter-moran/742998d893cd013edf6d0c86cc86ff7f
   Note that the nvvidconv flip-method was changed to 0. Earlier versions of L4T used a flip method of 2. 

## License
MIT License

Copyright (c) 2017 Jetsonhacks

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
 
gstreamer_view example Copyright (c) 2017 Peter Moran

