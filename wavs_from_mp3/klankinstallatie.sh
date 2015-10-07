#! /bin/bash

#
# opdracht klankinstallatie
# Vijay Weemhoff 2015
#

TARGETDIR=klankinstallatie_files
if [ -d $TARGETDIR ] ; then
  echo "$TARGETDIR directory exists"
else
  echo "creating $TARGETDIR directory"
  mkdir $TARGETDIR
fi

for f in *.wav; do
 sox $f `basename $f .wav`_t.wav trim 5.0 5.0
 sox --norm `basename $f .wav`_t.wav `basename $f .wav`_puur.wav fade h 0:01 0 0:01
 mv -i `basename $f .wav`_puur.wav ${TARGETDIR}
 rm `basename $f .wav`_t.wav
 done


for f in *.wav; do
 sox $f `basename $f .wav`_o.wav trim 2.0 2.0 overdrive 60 40 vol -0.5
 sox --norm `basename $f .wav`_o.wav `basename $f .wav`_overdrive.wav fade h 0:01 0 0:01
 mv -i `basename $f .wav`_overdrive.wav ${TARGETDIR}
 rm `basename $f .wav`_o.wav
 done

for f in *.wav; do
 sox $f `basename $f .wav`_l_r.wav trim 4.0 4.0 lowpass -2 300 gain -0.5 pad 0 0.5 reverb 25 
 sox --norm `basename $f .wav`_l_r.wav `basename $f .wav`_otherroom.wav fade h 0:01 0 0:01
 mv -i `basename $f .wav`_otherroom.wav ${TARGETDIR}
 rm `basename $f .wav`_l_r.wav
done

#kipcorn


