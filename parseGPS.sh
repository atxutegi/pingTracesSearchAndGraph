#!/bin/sh
echo "$1"
cat "$1"*_monroe_meta_device_gps.csv | grep ^$2 | cut -d, -f2 | cut -d, -f1 > time.txt
cat "$1"*_monroe_meta_device_gps.csv | grep ^$2 | cut -d, -f4 | cut -d, -f1 > altitude.txt
cat "$1"*_monroe_meta_device_gps.csv | grep ^$2 | cut -d, -f7 | cut -d, -f1 > latitude.txt
cat "$1"*_monroe_meta_device_gps.csv | grep ^$2 | cut -d, -f8 | cut -d, -f1 > longitude.txt
cat "$1"*_monroe_meta_device_gps.csv | grep ^$2 | cut -d\" -f3 | cut -d, -f3 > speed.txt
pr -m -t time.txt altitude.txt latitude.txt longitude.txt speed.txt > Node"$2"GPS.txt
rm time.txt altitude.txt latitude.txt longitude.txt speed.txt
