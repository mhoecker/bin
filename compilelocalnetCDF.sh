#!/bin/bash
LASTDIR=`pwd`
echo "Usage: $0 --zlib --fftw --hdf5 --netcdf --netcdff --udunits --nco"
ZLIB=0
FFTW=0
HDF5=0
NETCDF=0
NETCDFF=0
UDU=0
NCO=0
for i in "$@"
	do
	case $i in
		--zlib)
			ZLIB=1
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
		--nco)
			NCO=1
			shift
		;;
		*)
		echo "valid options are: --zlib --fftw --hdf5 --netcdf --netcdff --udunits --nco"
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
ZLIBVER="1.2.8"
ZLIBDIR="$LOCALSRC/zlib-$ZLIBVER"
ZLIBTAR="zlib-$ZLIBVER.tar.gz"
ZLIBURL="http://zlib.net/zlib-$ZLIBTAR"
# FFTW
FFTWVER="3.3.4"
FFTWDIR="$LOCALSRC/fftw-$FFTWVER"
FFTWTAR="fftw-$FFTWVER.tar.gz"
FFTWURL="http://www.fftw.org/$FFTWTAR"
#HDF5
HDF5VER="1.8.15-patch1"
HDF5DIR="$LOCALSRC/hdf5-$HDF5VER"
HDF5TAR="hdf5-$HDF5VER.tar.gz"
HDF5URL="http://www.hdfgroup.org/ftp/HDF5/current/src/$HDF5TAR"
# NETCDF 
NETCDFVER="4.3.3.1"
NETCDFDIR="$LOCALSRC/netcdf-$NETCDFVER"
NETCDFTAR="netcdf-$NETCDFVER.tar.gz"
NETCDFURL="ftp://ftp.unidata.ucar.edu/pub/netcdf/$NETCDFTAR"
# NETCDF-FORTRAN
NETCDFFVER="4.4.2"
NETCDFFDIR="$LOCALSRC/netcdf-fortran-$NETCDFFVER"
NETCDFFTAR="netcdf-fortran-$NETCDFFVER.tar.gz"
NETCDFFURL="ftp://ftp.unidata.ucar.edu/pub/netcdf/$NETCDFFTAR"
# UDUNITS
UDUVER="2.2.19"
UDUDIR="$LOCALSRC/udunits-$UDUVER"
UDUTAR="udunits-$UDUVER.tar.gz"
UDUURL="ftp://ftp.unidata.ucar.edu/pub/udunits/$UDUTAR"
# NCO
NCOVER="4.5.2"
NCODIR="$LOCALSRC/nco-$NCOVER"
NCOTAR="nco-$NCOVER.tar.gz"
NCOURL="http://nco.sourceforge.net/src/$NCOTAR"
#
echo "This script can install:"
echo "zlib version $ZLIBVER"
echo "fftw version $FFTWVER"
echo "netCDF version $NETCDFVER"
echo "netCDF FORTRAN interface version $NETCDFFVER"
echo "UDUNITS version $UDUVER"
echo "hdf5 version $HDF5VER"
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
	wget -c -N -nd -nH $NETCDFFURL -P $LOCALSRC
	tar -C $LOCALSRC -zxf $LOCALSRC/$NETCDFFTAR	
	#Configure and Make netCDF FORTRAN interface
	cd $NETCDFFDIR
	LDFLAGS="-L$LOCALLIB" \
	CPPFLAGS="-I$LOCALINC" \
	./configure --prefix=$LOCALPREFIX
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
	./configure --prefix=$LOCALPREFIX
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
	./configure --prefix=$LOCALPREFIX
	make
	make install
	make clean
fi
# Return to invoking directory
cd $LASTDIR
