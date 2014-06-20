walkman_ratings
===============

pulls rating(WALKMAN favorites playlist) from sony android phones standard providers.media db and trying to write them directly to files tags(using mutagen library https://code.google.com/p/mutagen/). 
music library on computer is managed by J River MediaCenter 19.

currently works only on rooted phone, because there is no access to db (/data/data/com.android.providers.media/databases/external.db) from adb shel without root.

music files are considered to be stored only on external storage.

written to work on windows with Cygwin (only affects path)
