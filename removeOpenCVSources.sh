#!/bin/bash
# License: MIT. See license file in root directory
# Copyright(c) JetsonHacks (2017-2018)

# Default installation is in the $HOME directory
cd $HOME
if [ -d "opencv" ] ; then
   if [ -L "opencv" ] ; then
     echo "opencv is a symlink, unable to remove"
   else
     echo "Removing opencv sources"
     sudo rm -r opencv
   fi
else
   echo "Could not find opencv directory"
fi

if [ -d "opencv_extra" ] ; then
   if [ -L "opencv_extra" ] ; then 
     echo "opencv_extra is a symlink, unable to remove"
   else
     echo "Removing opencv_extra sources"
     sudo rm -r opencv_extra
   fi
else
   echo "Could not find opencv_extra directory"
fi

