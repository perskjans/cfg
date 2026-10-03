#!/bin/bash

USE_PAMIXER=0


function toogle_play()
{
    xdotool key XF86AudioPlay
}


function volume_off()
{
    for _ in {1..40}; do
        pamixer -d 2
        sleep 0.1
    done
}

function volume_on()
{
    pamixer --set-volume 100
}


function play()
{
    total_seconds="$1"
    printf -v time_str '%(%M:%S)T' $total_seconds
    time_str="${time_str##0}"
    divider=3

    step=$(( total_seconds / divider ))
    if [[ $step -lt 80 ]]; then
        divider=2
        step=$(( total_seconds / divider ))

    fi

    steps=()

    step=$(( total_seconds / divider ))
    last_step=$total_seconds

    for (( i=1; i<$divider; i++ )); do
        steps+=($step)
        last_step=$(( last_step - step ))
    done

    steps+=($last_step)
    num_steps="${#steps[@]}"

    echo "Längd: $time_str ($total_seconds s)"
    echo "Byten: $divider"
    echo "Byteslängder: ${steps[@]}"
    echo

    for (( i=0; i<$num_steps; i++ )); do
        printf "$((i + 1))/$num_steps    "
        read -p "Press <Enter>" _
        sleep_time=${steps[$i]}
        pamixer --unmute


        if [[ $i -lt $num_steps ]]; then
            sleep_time=$((sleep_time - 4))
        fi

        toogle_play
        sleep $sleep_time

        if [[ $i -lt $num_steps ]]; then
            volume_off
            toogle_play
            sleep 0.5
            volume_on
        else
            toogle_play
        fi
    done
}

pamixer --mute
read -p "Press <Enter> to start" _
pamixer --unmute
echo

song_nr=1

while true; do
    metadata=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | grep -A2 -E ':length|:artist|:title' | grep -vE 'array|)|:' | tr -d '"')
    song_data=$(echo $metadata | sed 's/^.*uint64 //; s/-- string/<>/; s/-- variant.*string/<>/')

    length="${song_data%% <>*}"
    length=$(( length / 1000000 ))
    title="${song_data##*<> }"
    artist="${song_data#*<> }"
    artist="${artist%% <>*}"

    if [[ "$title" == "5 Seconds of Silence" ]]; then
        echo -e "\nSpellista slut"
        exit
    fi

    echo -e "\n\nSång $song_nr: $artist - $title"
    play "$length"
    song_nr=$((song_nr + 1))
done

