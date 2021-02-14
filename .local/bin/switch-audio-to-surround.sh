#! /bin/sh
amixer -c DX sset Master 45%,45%,15%,15%,40%,50%,0,0
amixer -c DX sset 'Stereo Upmixing' Front+Surround+Center/LFE+Back
amixer -c DX sset 'Front Panel' off
