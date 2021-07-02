# Webcam
Webcam frames taken each minute, sent by mqtt and video creation

## Overview
Photos are taken every minute by a Raspberry Pi Zero with camera and sent to the mqtt broker.

Every minute photos are put into a temporary directory.

At the end of the day, a new video is created from the images and published onto a web server.

<img src=schema_webcam.jpg>

## Raspberry Pi Zero code
#### camera.sh
```
#!/bin/bash
raspistill -w 648 -h 486 -o - | mosquitto_pub -h 192.168.10.253 -t pi0/camera -s
```

## Cloud code
#### subscribe_webcam.sh
```
#!/bin/bash

SEQ=$(echo "`date +%H`*60+`date +%M`"|bc)
TEMPDIR=/tmp/temp_webcam
WEBDIR=/www/webcam
if [ $SEQ -eq 0 ]; then
  cd $TEMPDIR
  ffmpeg -framerate 10 -pattern_type  glob -i "webcam*.jpg" $WEBDIR/webcam_`date +%Y%m%d`.avi
  cd ..
  rm -rf $TEMPDIR
fi

[ ! -d $TEMPDIR ] && mkdir -p $TEMPDIR
mosquitto_sub -h rb2vpn.robertoarcomano.com -t pi0/camera -C 1 > $TEMPDIR/webcam$SEQ.jpg
```
