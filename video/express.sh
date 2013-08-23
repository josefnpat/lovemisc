#!/bin/sh
ffmpeg -i $1 output.mp3
mkdir frames
ffmpeg -i $1 -r 25 -f image2 frames/frame-%0d.png
