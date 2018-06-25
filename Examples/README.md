There are two example programs here. Both programs require OpenCV to be installed with GStreamer support enabled.
Both of these examples were last tested with L4T 28.2, OpenCV 3.4.1

The first is a simple C++ program to view the onboard camera feed from the Jetson Dev Kit.

To compile gstreamer_view.cpp:

$ gcc -std=c++11 `pkg-config --cflags opencv` `pkg-config --libs opencv` gstreamer_view.cpp -o gstreamer_view -lstdc++ -lopencv_core -lopencv_highgui -lopencv_videoio

to run the program:

$ ./gstreamer_view

The second is a Python program that reads the onboard camera feed from the Jetson Dev Kit and does Canny Edge Detection.

To run the Canny detection demo (Python 2.7):

$ python cannyDetection.py

With Python 3.3:

$ python3 cannyDetection.py

With the Canny detection demo, use the less than (<) and greater than (>) to adjust the edge detection parameters.

## Notes

1. The gstreamer_view example is from Peter Moran:
   https://gist.github.com/peter-moran/742998d893cd013edf6d0c86cc86ff7f
   Note that the nvvidconv flip-method was changed to 0. Earlier versions of L4T used a flip method of 2.

2. For the Python examples, you will need to have the appropriate librariers installed. From the buildOpenCV scripts:

####     Python 2.7
    $ sudo apt-get install -y python-dev python-numpy python-py python-pytest
####     Python 3.5
    $ sudo apt-get install -y python3-dev python3-numpy python3-py python3-pytest


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
 
gstreamer_view example Copyright (c) 2017 Peter Moran

