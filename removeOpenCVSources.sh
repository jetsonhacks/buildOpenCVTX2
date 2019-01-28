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

for remove_dir in "opencv" "opencv_extra" "opencv_contrib"; do
    if [ -d ${remove_dir} ] ; then
       if [ -L ${remove_dir} ] ; then
         echo "${remove_dir} is a symlink, unable to remove"
       else
         echo "Removing ${remove_dir} sources"
         rm -r ${remove_dir}
       fi
    fi
done
