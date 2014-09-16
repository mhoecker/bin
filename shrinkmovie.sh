#!/bin/sh
## Test what kind of movie we want to make
VBR=768
ABR=128
SCALE=640
FPS=24
NAME="outmovie"
LOC="inmovie.m4v"
TYPE="mpg"
while getopts hv:f:l:n:t:w: opt
do
      case "$opt" in
            v)    VBR="$OPTARG"
                  echo "Video Bitrate $VBR";;
            v)    ABR="$OPTARG"
                  echo "Audio Bitrate $ABR";;
            f)    FPS="$OPTARG"
                  echo "Frame Rate $FPS";;
            l)    LOC=$OPTARG
                  echo "Source movie in $LOC";;
            n)    NAME=$OPTARG
                  echo "Ouput movie name $NAME";;
            t)    TYPE=$OPTARG
                  echo "Using encoding type $TYPE";;
            w)    SCALE=$OPTARG
                  echo "Using a with of $SCALE pixels";;
            h)    echo "This script transcodes a movie from an existing movie file."
                  echo "It uses  mencoder for mpeg1, mpeg4 and windows mpeg4 formats.\n"
                  echo "Usage: $0 [-v video bitrate] [-l location of input movie] [-n base name of output movie] [-t output type] [-w output width in pixels] [-f frame rate]\n"
                  echo "Output type can be:"
                  echo "avi\twindows compatible avi"
                  echo "mpg\tmpeg1 file"
                  echo "mov\tquicktime compatible mov"
                  echo "Default configuration:$0 -v $VBR -f $FPS -a $ABR -l $LOC -n $NAME -t $TYPE -w $SCALE"
                  exit 1;;
            \?) echo >&2 \
                  "Usage: $0 [-v video_bitrate] [-f frames_per_second] [-t output type] [-l location_of_pngs] [-n base_name_of_movie] [-w output width in pixels]"
            exit 1;;
      esac
done
echo "Creating movie $NAME.$TYPE from $LOC using video bitrate $VBR audio bitrate $ABR frame rate $FPS sacled to width $SCALE pixels"
case "$TYPE" in
#make the windows version
      avi)  nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,softskip,harddup -oac lavc -lavcopts acodec=ac3:abitrate=128 -ovc lavc -lavcopts vcodec=msmpeg4v2:vpass=1:vbitrate=$VBR:vpass=1 -of avi -o $NAME.$TYPE
            nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,softskip,harddup -oac lavc -lavcopts acodec=ac3:abitrate=128 -ovc lavc -lavcopts vcodec=msmpeg4v2:vpass=3:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -of avi  -o $NAME.$TYPE
            nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,softskip,harddup -oac lavc -lavcopts acodec=ac3:abitrate=128 -ovc lavc -lavcopts vcodec=msmpeg4v2:vpass=2:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -of avi  -o $NAME.$TYPE
            rm divx2pass.log;;
#make the mpeg1 version
      mpg) nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,decimate,softskip -oac lavc -lavcopts acodec=mp2:abitrate=$ABR -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg -o $NAME.$TYPE;;
#make the quicktime version
      mov)  nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,softskip,harddup -oac lavc -ovc lavc -lavcopts acodec=ac3:abitrate=$ABR:vcodec=mpeg4:vpass=1:vbitrate=$VBR:vpass=1:mbd=2 -of lavf -o $NAME.$TYPE
            nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,softskip,harddup -oac lavc -ovc lavc -lavcopts acodec=ac3:abitrate=$ABR:vcodec=mpeg4:vpass=3:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -of lavf -o $NAME.$TYPE
            nice -n 5 mencoder -quiet $LOC -vf scale=$SCALE:-2,denoise3d,softskip,harddup -oac lavc -ovc lavc -lavcopts acodec=ac3:abitrate=$ABR:vcodec=mpeg4:vpass=2:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -vf harddup -of lavf -o $NAME.$TYPE
            rm divx2pass.log;;
esac
