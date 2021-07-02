#!/bin/bash
raspistill -w 648 -h 486 -o - | mosquitto_pub -h 192.168.10.253 -t pi0/camera -s
