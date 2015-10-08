#! /bin/bash

#
# Opdracht klankinstallatie
# Vijay Weemhoff 2015
#

TARGETDIR=klankinstallatie_files
if [ -d $TARGETDIR ] ; then
  echo "$TARGETDIR directory exists"
  echo "Delete the directory before excecuting this script"
else
  read -n1 -p "No directory yet, shall I make directory for you? [y,n]" doit
  case $doit in 
  y|Y)
  echo ""
  echo "Yes! creating $TARGETDIR directory"
  mkdir $TARGETDIR ;;
  n|N) echo no, okay, its fine ;;
  *) echo "I dont know what you mean but i won't process the files" ;; 
  esac

echo "For every .wav file in this directory i'm going to make 4 little files"

read -n1 -p "Do you want to process the sounds? [y,n]" doit
echo ""
case $doit in  
  y|Y) echo "allright, lets go!" 
 for f in *.wav; do
  sox $f `basename $f .wav`_t.wav trim 5.0 5.0
  sox --norm `basename $f .wav`_t.wav `basename $f .wav`_puur.wav fade h 0:01 0 0:01
  mv -i `basename $f .wav`_puur.wav ${TARGETDIR}
  rm `basename $f .wav`_t.wav

  sox $f `basename $f .wav`_o.wav trim 2.0 2.0 overdrive 60 40 vol -0.5
  sox --norm `basename $f .wav`_o.wav `basename $f .wav`_overdrive.wav fade h 0:01 0 0:01
  mv -i `basename $f .wav`_overdrive.wav ${TARGETDIR}
  rm `basename $f .wav`_o.wav

  sox $f `basename $f .wav`_l_r.wav trim 4.0 4.0 lowpass -2 300 gain -0.5 pad 0 0.5 reverb 25 
  sox --norm `basename $f .wav`_l_r.wav `basename $f .wav`_otherroom.wav fade h 0:01 0 0:01
  mv -i `basename $f .wav`_otherroom.wav ${TARGETDIR}
  rm `basename $f .wav`_l_r.wav

  sox $f `basename $f .wav`_effect.wav trim 4.0 8.0 pitch -3000 phaser 0.8 0.74 3 0.4 0.5 reverse
  sox --norm `basename $f .wav`_effect.wav `basename $f .wav`_downpitch.wav fade h 0:01 0 0:01
  mv -i `basename $f .wav`_downpitch.wav ${TARGETDIR}
  rm `basename $f .wav`_effect.wav
 echo "working with $f now" 
 done ;; 
  n|N) echo no, okay, its fine ;; 
  *) echo "I dont know what you mean but i won't process the files" ;; 
esac

fi




#############################################################################################
# compositie maken
# 180 onderdelen 60 seconden 3 sporen alle samples 1 seconden.






