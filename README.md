# Webcam
Webcam frames taken each minute, sent by mqtt and video creation

## Overview
Photos are taken every minute by a Raspberry Pi Zero with camera, sent to the mqtt broker.

Every minute photos are put into a temporary directory.

At the end of the day, a new video is created from the images and published onto a web server.
<img src=schema_webcam.jpg>


