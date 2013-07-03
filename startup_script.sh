#!/bin/bash

if pgrep "nm-applet"
then
pkill "nm-applet"
fi

if pgrep "wallpaper.sh"
then
pkill "wallpaper.sh"
fi

if pgrep "compton"
then
pkill "compton"
fi

nm-applet  &
~/Pictures/wallpapers/wallpaper.sh  &
compton --config ~/.compton.conf -b
