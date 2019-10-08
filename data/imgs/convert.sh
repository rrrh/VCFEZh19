#!/bin/bash

for i in ../*_4bpp.png ; do
 	convert $i -resize 256x240\> -gravity center -background black -extent 256x240 $(basename $i)
done	
