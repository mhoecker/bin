#/bin/sh
makeindex $1.idx
latex -interaction=na $1.tex
dvips -o $1.ps $1.dvi
ps2pdf -dPDFSETTINGS=/prepress -dDoThumbnails $1.ps
