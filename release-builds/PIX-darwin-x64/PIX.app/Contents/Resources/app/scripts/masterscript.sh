#!/bin/sh

#Manages Removal of pics, download of pics & start of slideshow

#remove all pictures in the folder
rm -rf /home/pi/photoframe/final/*

#download pics from relevant sources (ie flickr & instagram)
#$1 = instagram Tag $3 = instagram user-id $3 = flickr Tag $4 = flickr user-id
#$5 = flickr_album_number


#download pics form instagram by tag
if [ "$1" != "BLANK" ]
then
  python -m instaLooter hashtag $1 /home/pi/photoframe/final -n 5
fi

#download pics from insta by person
if [ "$2" != "BLANK" ]
then
  python -m instaLooter $2 /home/pi/photoframe/final -N -n 5 --username teamfishermen --password fishermen1234
fi

#download pics from flickr by tag
if [ "$3" != "BLANK" ]
then
  wget 'http://api.flickr.com/services/feeds/photos_public.gne?tags='$3 -O- \
  | grep -Po 'http://[^.]+\.staticflickr[^"]+(_b.jpg|_z.jpg)' \
  | wget -P /home/pi/photoframe/final -nc -i-
fi

#download pics from flickr by person
if [ "$4" != "BLANK" && "$5" != "BLANK"]
then
  /home/pi/bin/download_flickr_set1.py $4 $5
fi


#display slideshow on pi
DISPLAY=:0.0 XAUTHORITY=/home/pi.Xauthority feh -Z -F -z -Y -D 2 /home/pi/photoframe/final &
