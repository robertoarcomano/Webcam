#!/bin/bash

SEQ=$(echo "`date +%H`*60+`date +%M`"|bc)
TEMPDIR=/tmp/temp_webcam
if [ $SEQ -eq 0 ]; then
  cd $TEMPDIR
  ffmpeg -framerate 10 -pattern_type  glob -i "webcam*.jpg" /www/webcam/webcam_`date +%Y%m%d`.avi
  cd ..
  rm -rf $TEMPDIR
fi

[ ! -d $TEMPDIR ] && mkdir -p $TEMPDIR
mosquitto_sub -h rb2vpn.robertoarcomano.com -t pi0/camera -C 1 > $TEMPDIR/webcam$SEQ.jpg

