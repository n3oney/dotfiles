#!/usr/bin/env bash


case "$1" in
  "volume")
    pamixer --get-volume; 
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r evt; 
      do pamixer --get-volume | cut -d " " -f1;
    done
    ;;
  "volume-speakers")
    speakers=$(pamixer --list-sinks | grep -e 'raop-sink' | awk '{print $1}')

    pamixer --get-volume --sink $speakers

    pactl subscribe \
        | grep --line-buffered "Event 'change' on sink #$speakers" \
        | while read -r evt;
        do pamixer --get-volume --sink $speakers | cut -d " " -f1;
    done
    ;;
  "muted")
      if [[ $(pamixer --get-mute) == "true" ]]; then
          echo "volume muted"
      else
          echo "volume"
      fi
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r evt; 
      do
      if [[ $(pamixer --get-mute) == "true" ]]; then
          echo "volume muted"
      else
          echo "volume"
      fi

    done
    ;;
  "speaker-muted")
    speakers=$(pamixer --list-sinks | grep -e 'raop-sink' | awk '{print $1}')

      if [[ $(pamixer --get-mute --sink $speakers) == "true" ]]; then
          echo "volume muted"
      else
          echo "volume"
      fi
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink #$speakers" \
      | while read -r evt; 
      do
      if [[ $(pamixer --get-mute --sink $speakers) == "true" ]]; then
          echo "volume muted"
      else
          echo "volume"
      fi

    done
    ;;
esac
