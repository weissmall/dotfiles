function getWallpaperByOutput() {
  output=$1
  outputsJson=$(waypaper --list | jq ".[] | select(.monitor==\"${output}\") | .wallpaper ")
  echo $outputsJson
}

function lock() {
  if [[ -x '/usr/bin/swaylock' ]]; then
    swaylock \
      --daemonize\
      --color "#282a2b"\
      --inside-color "#282a2b"\
      --inside-clear-color "#eeeeee"\
      --ring-color "#3b758c"\
      --ring-clear-color "#9fca56"\
      --ring-ver-color "#3498db"\
      --show-failed-attempts\
      --fade-in 0.2\
      --grace 1\
      --effect-blur 2x1\
      --effect-vignette 0.5:0.5\
      --ignore-empty-password\
      --image eDP-1:$(getWallpaperByOutput "eDP-1")\
      --image HDMI-A-1:$(getWallpaperByOutput "HDMI-A-1")\
      --clock
  fi
}

lock
