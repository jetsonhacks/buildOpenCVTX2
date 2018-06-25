#!/bin/bash
# License: MIT. See license file in root directory
# Copyright(c) JetsonHacks (2017-2018)

# Default installation is in the $HOME directory

OPENCV_SOURCE_DIR=$HOME

function usage
{
    echo "usage: ./removeOpenCVSources.sh [[-s sourcedir ] | [-h]]"
    echo "-d | --directory   Directory from which to remove the opencv sources (default $HOME)"
    echo "-h | --help  This message"
}

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -d | --directory )      shift
				OPENCV_SOURCE_DIR=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

echo "Removing opencv directory from $OPENCV_SOURCE_DIR"
cd $OPENCV_SOURCE_DIR

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

