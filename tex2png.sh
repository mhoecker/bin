#/bin/sh
echo "\documentclass[12pt]{article}" >> /tmp/$1.tex
echo "\usepackage{amsmath,amssymb,amsfonts,bm,color}" >> /tmp/$1.tex
echo "\pagestyle{empty}" >> /tmp/$1.tex
echo "\begin{document}" >> /tmp/$1.tex
echo "\begin{equation*}" >> /tmp/$1.tex
cat  $1 >> /tmp/$1.tex
echo "\end{equation*}" >> /tmp/$1.tex
echo "\end{document}" >> /tmp/$1.tex
cat /tmp/$1.tex
latex -output-directory=/tmp/ -interaction=batchmode /tmp/$1.tex
rm /tmp/$1.tex
rm /tmp/$1.log /tmp/$1.aux
dvipng -D 800 -bg transparent -T tight -z 3 /tmp/$1.dvi -q -pp 1 -o $1.png
rm /tmp/$1.dvi
