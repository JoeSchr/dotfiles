#!/usr/bin/env python3
# Run Program:
# "C:\path\to\utorrent-postprocess.pyw" "%L" "%S" "%N" "%K" "%F" "%D"
#
# Test with Console:
# python "C:\path\to\utorrent-postprocess.pyw" "Movie" "5" "Avatar" "multi" "" "X:\Files\Avatar"


import sys
import subprocess


# configuration
output = '/mnt/diskpool/NoMirror/Media'


# custom formats (use / instead of \ as directory separator)
movieFormat  = '''{plex}'''
seriesFormat = '''{plex}'''
animeFormat  = '''{plex}'''
musicFormat  = '''{plex}'''


# required args
label, state, title, kind, file, directory = sys.argv[1:7]

if label == "X":
    quit()

command = [
	'filebot', '-rename','-script', 'fn:amc',
	'--output', output,
	'--action', 'move',
	'--conflict', 'auto',
	'-non-strict',
	'--log-file', output + '/amc.log',
	'--def',
		'excludeList=amc.txt',
		'subtitle=en',
		'plex=127.0.0.1:s4x_QvW8Nn4svyx8fDtk',
		'deleteAfterExtract=n',
		'clean=y',
		'minFileSize=10',
		'unsorted=y',
		'music=n',
		'artwork=y',
		'movieFormat='  + movieFormat,
		'seriesFormat=' + seriesFormat,
		'animeFormat='  + animeFormat,
		'musicFormat='  + musicFormat,
		'ut_label=' + label,
		'ut_state=' + state,
		'ut_title=' + title,
		'ut_kind='  + kind,
		'ut_file='  + file,
		'ut_dir='   + directory

]


# execute command only for certain conditions (disabled by default)
'''
if state not in ['5', '11']:
	print('Illegal state: %s' % state)
	sys.exit(0)
'''


# execute command (and hide cmd window)
subprocess.run(command)
