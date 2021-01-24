#! /bin/sh
amixer -c DX sset 'Stereo Upmixing' Front
amixer -c DX sset 'Front Panel' on
# silence other channels
amixer -c DX sset Master 0%
# activate only front
amixer -c DX sset Master 10%,10%,-10%,0%,0%,0%,0%,0%
