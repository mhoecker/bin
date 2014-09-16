#/bin/sh
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPAPERSIZE=letter -sOutputFile=out.pdf *.ps
