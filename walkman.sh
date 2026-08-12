#! /bin/bash

source "walkman.conf"

music_style=""
song_counter=1
song_cache=0

function iterate_song() {
	root_path=$1

	for iterator in `ls "$root_path"`; do
		echo "Checking $root_path/$iterator"
		if [ -d "$root_path/$iterator" ]; then
			echo "Working on : $iterator"
			echo "==================================="
			echo "Current Dir : ${root_path}/${iterator}"
			iterate_song "${root_path}/${iterator}"
		else
			echo "File : $iterator"
			echo "==================================="
			if [[ "$iterator" == *.mp3 ]]; then
				if [ $song_counter -gt $song_cache ]; then
					play_song ${root_path}/${iterator}		
				fi
			
				song_counter=$(($song_counter + 1))
			fi
		fi
	done
}

function play_song() {
	mplayer $1
}

echo "###############################"
echo "         Walkman v1.0."
echo "###############################"

if [ $# -eq 1 ]; then
	music_style=$1
elif [ $# -eq 0 ]; then
	music_style="all"
else
	echo "Usage : walkman <music style>"
	echo "                all"
	echo "                english"
	echo "                chosen_english"
	echo "                traditional"
	echo "                pop"
	echo "                chosen_pop"

	exit 1
fi

IFS=$'\n'

case $music_style in
	all)
		;;

	english)
		echo "English there it is."
		echo "Root directory : $english_root"		
		echo "===================================="
		
		song_cache=$english_cache
		iterate_song $english_root 
		;;

	pop)
		;;

	*)
		echo "What do you mean $music_style it's not even exists!"
		;;	
esac


