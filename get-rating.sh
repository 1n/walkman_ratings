#!/bin/sh
#<<COMMENT1
#####claening and adbing
echo "-----cleaning-----"
pkill adb
rm favorites.m3u mc_favorites.m3u external.db.tmp

#connecting
adb connect mka:5555
#adb devices
<<COMMENT12
sleep 1

echo "-----pulling db------"
adb shell su -c "cp /data/data/com.android.providers.media/databases/external.db /data/local/tmp/external.db.tmp"
adb shell su -c "chmod 777 /data/local/tmp/external.db.tmp"
adb pull /data/local/tmp/external.db.tmp ./external.db.tmp
#COMMENT1

#<<COMMENT2
#####getting WALKMAN favourites from db in favorites.m3u
DB='external.db.tmp'
Q1="select _id from audio_playlists where name='WALKMAN favorites';"
PLID=`sqlite3 $DB "$Q1"`
#echo $PLID
Q2="SELECT _data FROM audio LEFT JOIN audio_playlists_map ON audio._id=audio_playlists_map.audio_id where audio_playlists_map.playlist_id=$PLID"
echo "-----favorites.m3u-----"
sqlite3 $DB "$Q2" | tee favorites.m3u
echo "-----------------------"
#LIST=`sqlite3 $DB "$Q2"`
#echo $LIST
#COMMENT2
COMMENT12
#####getting WALKMAN favourites from db in favorites.m3u
adb shell su -c "sqlite3 /data/data/com.android.providers.media/databases/external.db 'SELECT _data FROM audio LEFT JOIN audio_playlists_map ON audio._id=audio_playlists_map.audio_id where audio_playlists_map.playlist_id=4850'" | tee favorites.m3u

#####copying to mka
echo "copying to mka"
#cp favorites.m3u smb://mka/share2/PlaylistBackup/WALKMAN\ favorites.txt
cp favorites.m3u /cygdrive/m/PlaylistBackup/WALKMAN\ favorites\ script.txt
echo "-----------------------"

#<<COMMENT3
#####parsing for MediaCenter import 
echo "-----parsing-----"
echo "-----mc_favorites.m3u-----"
cat favorites.m3u | sed 's%'/storage/sdcard1'%'F:'%g' | sed 's/\//\\/g' | tee mc_favorites.m3u
echo "--------------------------"
#COMMENT3

#####copying playlist to mc watch folder
dt=$(date | sed 's%':'%'.'%g' | sed 's%\s%''%g')
echo "importing to mc"
cp mc_favorites.m3u /cygdrive/d/music.tmp/walkman\ import/WALKMAN\ favorites-$dt.m3u

#####need some code to write ratings directly to files