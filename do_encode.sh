#!/bin/bash

function encode
{
    mencoder -really-quiet $1 -vf scale=320:-2,denoise3d,decimate,softskip -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=768:mbd=2 -oac mp3lame -lameopts vbr=3 -of lavf -o $2 && mv $2 .
}

small=$(echo $1 | sed 's/\.mp4$/\small.mp4/')
small=$(echo $small | sed 's/\.MP4$/\small.mp4/')
small=$(echo $small | sed 's/\.wmv$/\small.mp4/')
small=$(echo $small | sed 's/\.WMV$/\small.mp4/')
if [ -e "$small" ] ; then
    rm $small
fi
encode "$1" "$small"
