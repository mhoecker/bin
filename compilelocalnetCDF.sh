#!/bin/bash
LASTDIR=`pwd`
echo "Usage: $0 --git --proj4 --gdal --zlib --fftw --hdf5 --netcdf --netcdff --udunits --antlr --nco"
ZLIB=0
FFTW=0
HDF5=0
NETCDF=0
NETCDFF=0
UDU=0
NCO=0
GIT=0
PROJ4=0
GDAL=0
ANTLR=0
for i in "$@"
	do
	case $i in
		--zlib)
			ZLIB=1
			shift
		;;
		--git)
			GIT=1
			shift
		;;
		--fftw)
			FFTW=1
			shift
		;;
		--hdf5)
			HDF5=1
			shift
		;;
		--netcdf)
			NETCDF=1
			shift
		;;
		--netcdff)
			NETCDFF=1
			shift
		;;		
		--udunits)
			UDU=1
			shift
		;;
		--antlr)
			ANTLR=1
			shift
		;;
		--nco)
			NCO=1
			shift
		;;
		--proj4)
			PROJ4=1
			shift
		;;
		--gdal)
			GDAL=1
			shift
		;;
		*)
		echo "valid options are: --git --gdal --proj4 --zlib --fftw --hdf5 --netcdf --netcdff --udunits --antlr --nco"
		;;
	esac
done
LOCALPREFIX="$HOME/local"
if [ ! -d $LOCALPREFIX ]; then
	mkdir $LOCALPREFIX
fi
LOCALLIB="$LOCALPREFIX/lib"
if [ ! -d $LOCALLIB ]; then
	mkdir $LOCALLIB
fi
LOCALINC="$LOCALPREFIX/include"
if [ ! -d $LOCALINC ]; then
	mkdir $LOCALINC
fi
LOCALSRC="$LOCALPREFIX/src"
if [ ! -d $LOCALSRC ]; then
	mkdir $LOCALSRC
fi
# zlib
ZLIBVER="1.2.11"
ZLIBDIR="$LOCALSRC/zlib-$ZLIBVER"
ZLIBTAR="zlib-$ZLIBVER.tar.gz"
ZLIBURL="http://www.zlib.net/$ZLIBTAR"
#git
GITVER="2.12.0"
GITDIR="$LOCALSRC/git-$GITVER"
GITTAR="git-$GITVER.tar.gz"
GITURL="https://www.kernel.org/pub/software/scm/git/$GITTAR"
# FFTW
FFTWVER="3.3.6-pl1"
FFTWDIR="$LOCALSRC/fftw-$FFTWVER"
FFTWTAR="fftw-$FFTWVER.tar.gz"
FFTWURL="http://www.fftw.org/$FFTWTAR"
#HDF5
HDF5VER="1.10.0-patch1"
HDF5DIR="$LOCALSRC/hdf5-$HDF5VER"
HDF5TAR="hdf5-$HDF5VER.tar.gz"
HDF5URL="http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.0-patch1/src/$HDF5TAR"
# NETCDF 
NETCDFVER="4.4.1.1"
NETCDFDIR="$LOCALSRC/netcdf-$NETCDFVER"
NETCDFTAR="netcdf-$NETCDFVER.tar.gz"
NETCDFURL="ftp://ftp.unidata.ucar.edu/pub/netcdf/$NETCDFTAR"
# NETCDF-FORTRAN
NETCDFFVER="4.4.4"
NETCDFFDIR="$LOCALSRC/netcdf-fortran-$NETCDFFVER"
NETCDFFTAR="netcdf-fortran-$NETCDFFVER.tar.gz"
NETCDFFURL="ftp://ftp.unidata.ucar.edu/pub/netcdf/$NETCDFFTAR"
# UDUNITS
UDUVER="2.2.24"
UDUDIR="$LOCALSRC/udunits-$UDUVER"
UDUTAR="udunits-$UDUVER.tar.gz"
UDUURL="ftp://ftp.unidata.ucar.edu/pub/udunits/$UDUTAR"
#ANTLR
ANTLRVER="2.7.7"
ANTLRDIR="$LOCALSRC/antlr-${ANTLRVER}"
ANTLRTAR="antlr-${ANTLRVER}.tar.gz"
ANTLRURL="http://www.antlr2.org/download/${ANTLRTAR}"
# NCO
NCOVER="4.6.4"
NCODIR="$LOCALSRC/nco-$NCOVER"
NCOTAR="nco-$NCOVER.tar.gz"
NCOURL="http://nco.sourceforge.net/src/$NCOTAR"
#PROJ4
PROJ4VER="4.9.3"
PROJ4TAR="proj-$PROJ4VER.tar.gz"
PROJ4URL="http://download.osgeo.org/proj/$PROJ4TAR"
PROJ4DIR="$LOCALSRC/proj-$PROJ4VER"
#GDAL
GDALVER="2.1.3"
GDALTAR="gdal-$GDALVER.tar.gz"
GDALURL="http://download.osgeo.org/gdal/$GDALVER/$GDALTAR"
GDALDIR="$LOCALSRC/gdal-$GDALVER"
#
echo "This script can install:"
echo "zlib version $ZLIBVER"
echo "git version $GITVER"
echo "fftw version $FFTWVER"
echo "netCDF version $NETCDFVER"
echo "netCDF FORTRAN interface version $NETCDFFVER"
echo "UDUNITS version $UDUVER"
echo "hdf5 version $HDF5VER"
echo "antlr version $ANTLRVER"
echo "nco version $NCOVER"
#INSTALL ZLIB
if [ "$ZLIB" -eq 1 ]; then
	#Get Zlib
	wget -c -N -nd -nH $ZLIBURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$ZLIBTAR
	#Configure and Make Zlib
	cd $ZLIBDIR
	./configure --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
#INSTALL GIT
if [ "$GIT" -eq 1 ]; then
	#Get git
	wget -c -N -nd -nH $GITURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$GITTAR
	#Configure and Make git
	cd $GITDIR
	./configure --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
# INSTALL FFTW?
if [ "$FFTW" -eq 1 ]; then
	#Get FFTW
	wget -c -N -nd -nH $FFTWURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$FFTWTAR
	#Configure and Make FFTW
	cd $FFTWDIR
	./configure --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
# Install HDF5?
if [ "$HDF5" -eq 1 ]; then
	#Get HDF5
	wget -c -N -nd -nH $HDF5URL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$HDF5TAR
	#Configure and Make HDF5
	cd $HDF5DIR
	./configure --with-zlib=$LOCALPREFIX --prefix=$LOCALPREFIX --enable-fortran
	make
	make install
	make clean
fi
# INSTALL NETCDF?
if [ "$NETCDF" -eq 1 ]; then
	#Get netCDF
	wget -c -N -nd -nH $NETCDFURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$NETCDFTAR	
	#Configure and Make netCDF
	cd $NETCDFDIR
	LDFLAGS="-L$LOCALLIB" \
	CPPFLAGS="-I$LOCALINC" \
	./configure --prefix=$LOCALPREFIX --enable-netcdf-4 --enable-dap
	make
	make install
	make clean
fi
#INSTALL NETCDF FORTRAN INTERFACE?
if [ "$NETCDFF" -eq 1 ]; then
	#Get netCDF FORTRAN library
	echo $NETCDFFURL
	wget -c -N -nd -nH $NETCDFFURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$NETCDFFTAR	
	#Configure and Make netCDF FORTRAN interface
	cd $NETCDFFDIR
	LDFLAGS="-L$LOCALLIB" \
	CPPFLAGS="-I$LOCALINC" \
	./configure --quiet --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
# INSTALL UDUNITS?
if [ "$UDU" -eq 1 ]; then
	#Get udunits library
	wget -c -N -nd -nH $UDUURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$UDUTAR	
#Configure and Make UDUNITS
	cd $UDUDIR
	./configure --quiet --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
# INSTALL ANTLR?
if [ "$ANTLR" -eq 1 ]; then
	#Get ANTLR
	wget -c -N -nd -nH $ANTLRURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$ANTLRTAR
	# 
	cd $ANTLRDIR
	sed -i "13a #include <strings.h>" lib/cpp/antlr/CharScanner.hpp
	sed -i "14a #include <stdio.h>" lib/cpp/antlr/CharScanner.hpp
	./configure --quiet --prefix=$LOCALPREFIX 
	make
	make install
	make clean
fi
# INSTALL NCO?
if [ "$NCO" -eq 1 ]; then
	#Get netCDF operators
	wget -c -N -nd -nH $NCOURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$NCOTAR	
	#Configure and Make NCO
	cd $NCODIR
	LDFLAGS="-L$LOCALLIB" \
	CPPFLAGS="-I$LOCALINC" \
	./configure --quiet --prefix=$LOCALPREFIX 
	make
	make install
	make clean
fi
# INSTALL PROJ4?
if [ "$PROJ4" -eq 1 ]; then
	#Get proj4
	wget -c -N -nd -nH $PROJ4URL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$PROJ4TAR
	cd $PROJ4DIR
	./configure --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
#INSTALL GDAL?
if [ "$GDAL" -eq 1 ]; then
	#Get GDAL
	wget -c -N -nd -nH $GDALURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$GDALTAR
	cd $GDALDIR
	pwd
	LDFLAGS="-L$LOCALLIB" \
	CPPFLAGS="-I$LOCALINC" \
	./configure --prefix=$LOCALPREFIX --with-libz=$LOCALLIB
	make
	make install
	make clean
fi
# Return to invoking directory
cd $LASTDIR
