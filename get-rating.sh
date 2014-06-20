#!/bin/sh

#pkill adb

#connecting
adb connect mka:5555
#query
echo -e "\n query"
echo -e "\n --------------------------"
adb shell su -c "sqlite3 /data/data/com.android.providers.media/databases/external.db 'SELECT DISTINCT _data FROM audio LEFT JOIN audio_playlists_map ON audio._id=audio_playlists_map.audio_id where audio_playlists_map.playlist_id=4850' | tee /storage/sdcard1/PlaylistBackup/WALKMAN\ favorites.txt"
echo -e "\n --------------------------"

#pulling
echo -e "\n pulling \n"
adb pull /storage/sdcard1/PlaylistBackup/WALKMAN\ favorites.txt favorites.m3u

#parsing
echo -e "\n parsing"
echo -e "\n --------------------------"
cat favorites.m3u | sed 's%'/storage/sdcard1'%'F:'%g' | sed 's/\//\\/g' | tee mc_favorites.m3u
echo -e "\n --------------------------"

#copying playlist to mc watch folder
dt=$(date +%d%m%y_%H.%M)
echo -e "\n importing to mc"
cp mc_favorites.m3u /cygdrive/d/music.tmp/walkman\ import/WALKMAN\ favorites-$dt.m3u

echo -e "\n cleaning \n"
rm favorites.m3u mc_favorites.m3u

#need some code to write ratings directly to mc files

#need some code to import ratings directly in android media database
#need some code to import MC ratings in android media database

read -p " done"