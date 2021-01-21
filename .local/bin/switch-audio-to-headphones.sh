#! /bin/sh
amixer -c DX sset 'Stereo Upmixing' Front
amixer -c DX sset 'Front Panel' on
# silecne other channels
# amixer -c DX sset Master 0%
# activate only front
amixer -c DX sset Master 100%,100%,0%,0%,0%,0%,0%,0%
