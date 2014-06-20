#!/bin/sh

#####copying WALKMAN favorites.txt from mka
echo "copying WALKMAN favorites.txt from mka"
#cp favorites.m3u smb://mka/share2/PlaylistBackup/WALKMAN\ favorites.txt
cp /cygdrive/m/PlaylistBackup/WALKMAN\ favorites.txt /cygdrive/d/music.tmp/WALKMAN\ favorites.m3u
echo "-----------------------"

#####parsing for MediaCenter import 
echo "-----parsing-----"
echo "-----mc_favorites_p.m3u-----"
cat favorites_p.m3u | sed 's%'/storage/sdcard1'%'F:'%g' | sed 's/\//\\/g' | tee mc_favorites_p.m3u
echo "--------------------------"
