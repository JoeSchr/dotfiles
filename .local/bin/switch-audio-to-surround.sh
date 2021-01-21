#! /bin/sh
amixer -c DX sset Master 20%
amixer -c DX sset 'Stereo Upmixing' Front+Surround+Center/LFE+Back
amixer -c DX sset 'Front Panel' off
