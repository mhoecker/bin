#/bin/sh
gs -q -dNOPAUSE -dBATCH -dFIXMEDIA -dAutoRotatePages=/PageByPage -sDEVICE=pdfwrite -sPAPERSIZE=letter -sOutputFile=out.pdf *.eps
