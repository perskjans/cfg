#!/bin/bash


function dbus_send()
{
    local args='--print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 '

    case "$1" in
        play) dbus-send $args org.mpris.MediaPlayer2.Player.Play >/dev/null ;;
        pause) dbus-send $args org.mpris.MediaPlayer2.Player.Pause >/dev/null ;;
        setpos) dbus-send $args org.mpris.MediaPlayer2.Player.SetPosition objpath:$TRACKID int64:0 >/dev/null ;;
        metadata)
            dbus-send $args org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | grep -E 'string|uint64' | sed -E 's/^.*(string|uint64) //g' | tr -d '"' | grep -A1 -E ':trackid|:length|:artist|:title' | grep -vE ':|^--$'
            ;;
    esac
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
    local total_seconds="$1"
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

    for (( i=0; i<$num_steps; i++ )); do
        printf "$((i + 1))/$num_steps    "
        read -p "Press <Enter>" _
        sleep_time=${steps[$i]}
        pamixer --unmute


        if [[ $i -lt $num_steps ]]; then
            sleep_time=$((sleep_time - 4))
        fi

        dbus_send "play"
        sleep $sleep_time

        if [[ $i -lt $num_steps ]]; then
            volume_off
            #toogle_play
            dbus_send "pause"
            sleep 0.2
            volume_on
        else
            dbus_send "play"
        fi
    done
}

pamixer --mute
read -p "Press <Enter> to start" _
dbus_send 'pause'
pamixer --unmute
echo

song_nr=1

while true; do
    mapfile -t metadata < <(dbus_send 'metadata')

    TRACKID="${metadata[0]}"
    TRACK_LENGTH=$(( metadata[1] / 1000000 ))
    ARTIST="${metadata[2]}"
    TITLE="${metadata[3]}"

    if [[ "$TITLE" == "5 Seconds of Silence" ]]; then
        echo -e "\nSpellista slut"
        exit
    fi

    dbus_send 'setpos'
    echo -e "\n\nSång $song_nr: $ARTIST - $TITLE"
    play "$TRACK_LENGTH"
    song_nr=$((song_nr + 1))
done

