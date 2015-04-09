#!/bin/bash
LOCALPREFIX="/home/mhoecker/local"
LOCALLIB="$LOCALPREFIX/lib"
LOCALINC="$LOCALPREFIX/include"
LOCALSRC="$LOCALPREFIX/src"
ZLIBDIR="$LOCALSRC/zlib-1.2.7"
FFTWDIR="$LOCALSRC/fftw-3.3"
HDF5DIR="$LOCALSRC/hdf5-1.8.10-patch1"
UDUDIR="$LOCALSRC/udunits-2.1.24"
NETCDFDIR="$LOCALSRC/netcdf-c-4.3.3.1"
NETCDFFDIR="$LOCALSRC/netcdf-fortran-4.4.2"
UDUDIR="$LOCALSRC/udunits-2.2.19"
NCODIR="$LOCALSRC/nco-4.4.8"
#
#Configure and Make Zlib
# cd $ZLIBDIR
# ./configure --prefix=$LOCALPREFIX
# make
# make install
# make clean
#Configure and Make FFTW
# cd $FFTWDIR
# ./configure --prefix=$LOCALPREFIX
# make
# make install
# make clean
#Configure and Make HDF5
# cd $HDF5DIR
# ./configure --with-zlib=$LOCALPREFIX --prefix=$LOCALPREFIX --enable-fortran
# make
# make install
# make clean
#Configure and Make netCDF
# cd $NETCDFDIR
# LDFLAGS="-L$LOCALLIB" \
# CPPFLAGS="-I$LOCALINC" \
# ./configure --prefix=$LOCALPREFIX --enable-netcdf-4 --enable-dap
# make
# make install
# make clean
#Configure and Make netCDF FORTRAN interface
# cd $NETCDFFDIR
# LDFLAGS="-L$LOCALLIB" \
# CPPFLAGS="-I$LOCALINC" \
# ./configure --prefix=$LOCALPREFIX
# make
# make install
# make clean
#Configure and Make UDUNITS
# cd $UDUDIR
# ./configure --prefix=$LOCALPREFIX
# make
# make install
# make clean
#Configure and Make NCO
# cd $NCODIR
# LDFLAGS="-L$LOCALLIB" \
# CPPFLAGS="-I$LOCALINC" \
# ./configure --prefix=$LOCALPREFIX
# make
# make install
# make clean
#cd $LOCALSRC
