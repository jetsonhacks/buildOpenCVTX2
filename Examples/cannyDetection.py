#!/usr/bin/env python
# MIT License

# Copyright (c) 2017-18 Jetsonhacks

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import sys
import argparse
import cv2
import numpy as np

def parse_cli_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--video_device", dest="video_device",
                        help="Video device # of USB webcam (/dev/video?) [0]",
                        default=0, type=int)
    arguments = parser.parse_args()
    return arguments

# On versions of L4T previous to L4T 28.1, flip-method=2
# Use the Jetson onboard camera
def open_onboard_camera():
    return cv2.VideoCapture("nvcamerasrc ! video/x-raw(memory:NVMM), width=(int)640, height=(int)480, format=(string)I420, framerate=(fraction)30/1 ! nvvidconv ! video/x-raw, format=(string)BGRx ! videoconvert ! video/x-raw, format=(string)BGR ! appsink")

# Open an external usb camera /dev/videoX
def open_camera_device(device_number):
    return cv2.VideoCapture(device_number)
   

def read_cam(video_capture):
    if video_capture.isOpened():
        windowName = "CannyDemo"
        cv2.namedWindow(windowName, cv2.WINDOW_NORMAL)
        cv2.resizeWindow(windowName,1280,720)
        cv2.moveWindow(windowName,0,0)
        cv2.setWindowTitle(windowName,"Canny Edge Detection")
        showWindow=3  # Show all stages
        showHelp = True
        font = cv2.FONT_HERSHEY_PLAIN
        helpText="'Esc' to Quit, '1' for Camera Feed, '2' for Canny Detection, '3' for All Stages. '4' to hide help"
        edgeThreshold=40
        showFullScreen = False
        while True:
            if cv2.getWindowProperty(windowName, 0) < 0: # Check to see if the user closed the window
                # This will fail if the user closed the window; Nasties get printed to the console
                break;
            ret_val, frame = video_capture.read();
            hsv=cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            blur=cv2.GaussianBlur(hsv,(7,7),1.5)
            edges=cv2.Canny(blur,0,edgeThreshold)
            if showWindow == 3:  # Need to show the 4 stages
                # Composite the 2x2 window
                # Feed from the camera is RGB, the others gray
                # To composite, convert gray images to color. 
                # All images must be of the same type to display in a window
                frameRs=cv2.resize(frame, (640,360))
                hsvRs=cv2.resize(hsv,(640,360))
                vidBuf = np.concatenate((frameRs, cv2.cvtColor(hsvRs,cv2.COLOR_GRAY2BGR)), axis=1)
                blurRs=cv2.resize(blur,(640,360))
                edgesRs=cv2.resize(edges,(640,360))
                vidBuf1 = np.concatenate( (cv2.cvtColor(blurRs,cv2.COLOR_GRAY2BGR),cv2.cvtColor(edgesRs,cv2.COLOR_GRAY2BGR)), axis=1)
                vidBuf = np.concatenate( (vidBuf, vidBuf1), axis=0)

            if showWindow==1: # Show Camera Frame
                displayBuf = frame 
            elif showWindow == 2: # Show Canny Edge Detection
                displayBuf = edges
            elif showWindow == 3: # Show All Stages
                displayBuf = vidBuf

            if showHelp == True:
                cv2.putText(displayBuf, helpText, (11,20), font, 1.0, (32,32,32), 4, cv2.LINE_AA)
                cv2.putText(displayBuf, helpText, (10,20), font, 1.0, (240,240,240), 1, cv2.LINE_AA)
            cv2.imshow(windowName,displayBuf)
            key=cv2.waitKey(10)
            if key == 27: # Check for ESC key
                cv2.destroyAllWindows()
                break ;
            elif key==49: # 1 key, show frame
                cv2.setWindowTitle(windowName,"Camera Feed")
                showWindow=1
            elif key==50: # 2 key, show Canny
                cv2.setWindowTitle(windowName,"Canny Edge Detection")
                showWindow=2
            elif key==51: # 3 key, show Stages
                cv2.setWindowTitle(windowName,"Camera, Gray scale, Gaussian Blur, Canny Edge Detection")
                showWindow=3
            elif key==52: # 4 key, toggle help
                showHelp = not showHelp
            elif key==44: # , lower canny edge threshold
                edgeThreshold=max(0,edgeThreshold-1)
                print ('Canny Edge Threshold Maximum: ',edgeThreshold)
            elif key==46: # , raise canny edge threshold
                edgeThreshold=edgeThreshold+1
                print ('Canny Edge Threshold Maximum: ', edgeThreshold)
            elif key==74: # Toggle fullscreen; This is the F3 key on this particular keyboard
                # Toggle full screen mode
                if showFullScreen == False : 
                    cv2.setWindowProperty(windowName, cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)
                else:
                    cv2.setWindowProperty(windowName, cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_NORMAL) 
                showFullScreen = not showFullScreen
              
    else:
     print ("camera open failed")



if __name__ == '__main__':
    arguments = parse_cli_args()
    print("Called with args:")
    print(arguments)
    print("OpenCV version: {}".format(cv2.__version__))
    print("Device Number:",arguments.video_device)
    if arguments.video_device==0:
      video_capture=open_onboard_camera()
    else:
      video_capture=open_camera_device(arguments.video_device)
    read_cam(video_capture)
    video_capture.release()
    cv2.destroyAllWindows()
