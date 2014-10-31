#!/bin/sh
## Test what kind of movie we want to make
VBR=768
FPS=10
SCALE=640
NAME="movie"
LOC="png/"
TYPE="mpg"
while getopts hv:f:l:n:t:w: opt
do
      case "$opt" in
            v)    VBR="$OPTARG"
                  echo "Video Bitrate $VBR";;
            f)    FPS=$OPTARG
                  echo "Frames per second $FPS";;
            l)    LOC=$OPTARG
                  echo "Source pngs in $LOC";;
            n)    NAME=$OPTARG
                  echo "Movie name $NAME";;
            t)    TYPE=$OPTARG
                  echo "Using encoding type $TYPE";;
            w)    SCALE=$OPTARG
                  echo "Using a with of $SCALE pixels";;
            h)    echo "This script makes movies from a series of sequentially numbered png files."
                  echo "It uses convert for animated gifs and mencoder for mpeg1, mpeg4 and windows mpeg4 formats.\n"
                  echo "animated gif uses the frames per second as the delay between frames.\n"
                  echo "Usage: $0 [-v video_bitrate] [-f frames_per_second] [-l location_of_pngs] [-n base_name_of_movie] [-t output type] [-w output width in pixels]\n"
                  echo "Output type can be:"
                  echo "gif\tanimated gif"
                  echo "avi\twindows compatible avi"
                  echo "mpg\tmpeg1 file"
                  echo "mov\tquicktime compatible mov"
                  echo "ogv\tOgg Vorbis compattible ogv"
                  echo "Default configuration:$0 -v $VBR -f $FPS -l $LOC -n $NAME -t $TYPE -w $SCALE"
                  exit 1;;
            \?) echo >&2 \
                  "Usage: $0 [-v video_bitrate] [-f frames_per_second] [-t output type] [-l location_of_pngs] [-n base_name_of_movie] [-w output width in pixels]"
            exit 1;;
      esac
done
echo "Creating movie $NAME.$TYPE from png files in $LOC using bitrate $VBR frame rate $FPS sacled to width $SCALE pixels"
case "$TYPE" in
#make animated gif
      gif)  convert -delay $FPS -loop 0  $LOC*.png animated.gif;;
#make the windows version
      avi)  nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d -ovc lavc -lavcopts vcodec=msmpeg4v2:vpass=1:vbitrate=$VBR:vpass=1:mbd=2 -nosound -of avi -o $NAME.$TYPE
            nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d -ovc lavc -lavcopts vcodec=msmpeg4v2:vpass=3:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -nosound -of avi  -o $NAME.$TYPE
            nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d -ovc lavc -lavcopts vcodec=msmpeg4v2:vpass=2:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -nosound -of avi  -o $NAME.$TYPE
            rm divx2pass.log;;
#make the vorbis version
      ogv)  nice -n 5 avconv -y -pass 1 -r $FPS -vb ${VBR}k -vf scale=$SCALE:-1 -i $LOC%04d.png  $NAME.$TYPE
            nice -n 5 avconv -y -pass 2 -r $FPS -vb ${VBR}k -vf scale=$SCALE:-1 -i $LOC%04d.png  $NAME.$TYPE
            rm av2pass-0.log;;
#make the mpeg1 version
      mpg) nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d,decimate,softskip -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg -o $NAME.$TYPE;;
#make the quicktime version
      mov)  nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d -ovc lavc -lavcopts vcodec=mpeg4:vpass=1:vbitrate=$VBR:vpass=1:mbd=2 -nosound -of lavf -o $NAME.$TYPE
            nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d -ovc lavc -lavcopts vcodec=mpeg4:vpass=3:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -nosound -of lavf -o $NAME.$TYPE
            nice -n 5 mencoder -quiet mf://$LOC*.png -mf type=png:fps=$FPS -vf scale=$SCALE:-2,denoise3d -ovc lavc -lavcopts vcodec=mpeg4:vpass=2:vbitrate=$VBR:trell:mbd=2:dia=4:last_pred=3 -nosound -of lavf -o $NAME.$TYPE
            rm divx2pass.log;;
esac
echo "Created movie $NAME.$TYPE from png files in $LOC using bitrate $VBR frame rate $FPS sacled to width $SCALE pixels"
