#! /usr/bin/bash

rm /mnt/diskpool/NoMirror/Media/amc.txt

filebot -rename -script fn:amc  --log-file amc.log --output "/mnt/diskpool/NoMirror/Media"  --action move -non-strict "/mnt/diskpool/NoMirror/Downloads/Finished" --conflict auto --def excludeList=amc.txt  movieFormat="{plex}" seriesFormat="{plex}" subtitles=en  music=n  plex=127.0.0.1:V6zq1wd1L7sXpmNLC9Qn  deleteAfterExtract=n  clean=y   unsorted=y   minFileSize=10


# 1eb949eb75be5c2e64884ab6eb2f1fc8c11c63ed
# --def movieFormat="M:/{plex}" seriesFormat="S:/{plex}" animeFormat="T:/{plex}" musicFormat="D:/{plex}"
# --filter "age < 5 || 5 <= model.age.min()" --def "ut_label=TV"
