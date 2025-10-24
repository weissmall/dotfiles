#!/bin/bash
function getWallpaperByOutput() {
  output=$1
  outputsJson=$(waypaper --list | jq ".[] | select(.monitor==\"${output}\") | .wallpaper ")
  echo $outputsJson
}

function getWallpaperByOutputOrAll() {
  output=$1
  wallpaper=$(getWallpaperByOutput "${output}")
  if [[ -n $wallpaper ]]; then
    echo $wallpaper
  else
    echo $(getWallpaperByOutput "All")
  fi
}

function getImagesPerOutput() {
  niriOutputs=$(niri msg outputs | grep "Output" | grep -oE '\(.*\)' | tr -d '()')
  niriOutputsArray=($niriOutputs)

  result=""
  for i in "${niriOutputsArray[@]}"; do
    wallpaper=$(getWallpaperByOutputOrAll $i)
    result+="--image $i:$wallpaper "
  done

  result=${result% }
  echo $result
}



function lock() {
  if [[ -x '/usr/bin/swaylock' ]]; then
    swaylock \
      --daemonize\
\
      --inside-clear-color "#3E4244"\
      --line-clear-color "#3E4244"\
      --ring-clear-color "#A4C9E3"\
      --text-clear-color "#FFFFFF"\
\
      --inside-ver-color "#35424A"\
      --line-ver-color "#35424A"\
      --ring-ver-color "#A4C9E3"\
      --text-ver-color "#FFFFFF"\
\
      --inside-wrong-color "#4A3535"\
      --line-wrong-color "#4A3535"\
      --ring-wrong-color "#E3A4A4"\
      --text-wrong-color "#FFFFFF"\
\
      --inside-color "#3E4244"\
      --line-color "#3E4244"\
      --ring-color "#A4C9E3"\
      --text-color "#FFFFFF"\
\
      --text-caps-lock-color "#FFFFFF"\
\
      --key-hl-color "#FFFFFF"\
      --bs-hl-color "#808080"\
\
      --show-failed-attempts\
      --fade-in 0.2\
      --grace 1\
      --effect-blur 2x1\
      --effect-vignette 0.5:0.5\
      --ignore-empty-password\
      $(getImagesPerOutput) \
      --clock \
      -e
  fi
}


lock >> $HOME/lock.log
