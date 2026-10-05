#!/bin/bash

reset

function dbus_send()
{
    local args='--print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 '
    local query_args="$args org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata"

    local get_prop='org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player'

    case "$1" in
        next) dbus-send $args org.mpris.MediaPlayer2.Player.Next >/dev/null ;;
        play) dbus-send $args org.mpris.MediaPlayer2.Player.Play >/dev/null ;;
        stop) dbus-send $args org.mpris.MediaPlayer2.Player.Stop >/dev/null ;;
        getpos) dbus-send $args $get_prop string:"Position" | sed 's/^.*\ //' ;;
        setpos) dbus-send $args org.mpris.MediaPlayer2.Player.SetPosition objpath:$TRACKID int64:0 >/dev/null ;;

        metadata)
            dbus-send $query_args  | sed 's/uint64/string/g; s/"//g; s/.*string //g; /array/d' | sed -n "/:$2/{n;p}" ;;
    esac
}

function volume_off()
{
    while [[ $(pamixer --get-volume) -gt 20 ]]; do
    # for _ in {1..40}; do
        pamixer -d 2

        if [[ $(pamixer --get-volume) -eq 20 ]]; then
            return
        fi

        sleep 0.1
    done
}

function volume_on()
{
    #pamixer --set-volume 100
    if [[ $(pamixer --get-volume) -eq 100 ]]; then
        return
    fi

    while [[ $(pamixer --get-volume) -lt 100 ]]; do
    # for _ in {1..40}; do
        pamixer -i 2

        if [[ $(pamixer --get-volume) -eq 100 ]]; then
            return
        fi

        sleep 0.1
    done
}


function play()
{
    local total_time=$(dbus_send 'metadata' 'length')
    local total_seconds=$(( total_time / 1000000 ))
    printf -v time_str '%(%M:%S)T' $total_seconds
    local time_str="${time_str##0}"
    local divider=4

    local step=$(( total_seconds / divider ))

    while [[ $step -lt 80 ]] && [[ $divider -ne 2 ]]; do
       divider=$(( divider - 1 ))
       step=$(( total_seconds / divider ))
    done

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

    i=0
    while true; do
        sleep_time=${steps[$i]}
        i=$((i + 1))
        printf "$i/$num_steps    "
        read -p "Press <Enter>" input

        if [[ "$input" != "" ]]; then
            dbus_send 'next'
            sleep 1
            return
        fi

        pamixer --unmute

        if [[ $i -eq 1 ]] || [[ $i -eq $num_steps ]]; then
            # Time for fading up or down volume
            sleep_time=$((sleep_time - 4))
        else
            # Time for fading up and down volume
            sleep_time=$((sleep_time - 8))
        fi

        dbus_send "play"
        volume_on

        if [[ $i -eq $num_steps ]]; then
            while [[ "$(dbus_send 'metadata' 'title')" == "$TITLE" ]]; do
                sleep 0.1
            done
            sleep 2
            pamixer --mute
            dbus_send "stop"
            return
        else
            sleep  ${sleep_time}
            volume_off
            dbus_send "stop"
        fi
    done
}

pamixer --mute
read -p "Press <Enter> to start" _
dbus_send 'stop'
echo

song_nr=1

while true; do

    ARTIST="$(dbus_send 'metadata' 'artist')"
    TITLE="$(dbus_send 'metadata' 'title')"
    TRACKID="$(dbus_send 'metadata' 'trackid')"

    if [[ "$TITLE" == "5 Seconds of Silence" ]]; then
        dbus_send "stop"
        pamixer --unmute
        echo -e "\nSpellista slut"
        exit
    fi

    dbus_send 'setpos'
    pamixer --set-volume 100
    echo -e "\n\nSång $song_nr: $ARTIST - $TITLE"
    play
    song_nr=$((song_nr + 1))
done

