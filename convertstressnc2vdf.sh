#/bin/sh
Nx=32
Ny=32
Nz=32
n=2
i=0
l=3
time=0
ncdf="hi.nc"
vdf="hi.vdf"
while getopts hx:y:z:n:s:l:i:o: opt
do
      case "$opt" in
            i)    ncdf=$OPTARG
                  echo "using $ncdf as the input file";;
            o)    vdf=$OPTARG
                  echo "using $vdf as the output file";;
            n)    n=$OPTARG
                  echo "converting $n time steps";;
            l)    l=$OPTARG
                  echo "using $l refinement levels";;
            s)    i=$OPTARG
                  echo "starting from step $i";;
            x)    Nx=$OPTARG
                  echo "$Nx points in the x direction";;
            y)    Ny=$OPTARG
                  echo "$Ny points in the y direction";;
            z)    Nz=$OPTARG
                  echo "$Nz points in the Z direction";;
            h)    echo "This script converts a netcdf file into a VAPOR data collection."
                  echo "Assumes the netcdf file has variables U, V, W, and b with dimensions X, Y, Z and t where X and Y are periodic."
                  echo "It uses vdfcreate to setup the data collecton and ncdf2vdf for the conversion of each variable at each time step.\n"
                  echo "Usage: $0 [-x # X points] [-y # of Y points] [-z # of Z points] [-n # of time steps] [-s starting step] [-l refinement level] [-i input.nc] [-o output.vdf]"
                  echo "Default configuration:$0 -x $Nx -y $Ny -z $Nz -n $n -s $i -l $l -i $ncdf -o $vdf"
                  exit 1;;
            \?)   echo "Usage: $0 [-x # X points] [-y # of Y points] [-z # of Z points] [-n # of time steps] [-s starting step] [-l refinement level]"
                  echo "Default configuration:$0 -x $Nx -y $Ny -z $Nz -n $n -s $i -l $l -i $ncdf -o $vdf"
                  exit 1;;
      esac
done
time=$i
i=0
vapor-setup.sh
vdfcreate -dimension ${Nz}x${Ny}x${Nx} -numts $n -level $l -periodic 0:1:1 -vars3d U:V:W:b $vdf
while [ $i -lt $n ]
do
 echo "converting netcdf step $time to vdc step $i"
 ncdf2vdf -quiet -ts ${i} -varname b -ncdfvar b -dimnames Z:Y:X -cnstnames t -cnstvals ${time} $vdf $ncdf
 ncdf2vdf -quiet -ts ${i} -varname U -ncdfvar U -dimnames Z:Y:X -cnstnames t -cnstvals ${time} $vdf $ncdf
 ncdf2vdf -quiet -ts ${i} -varname V -ncdfvar V -dimnames Z:Y:X -cnstnames t -cnstvals ${time} $vdf $ncdf
 ncdf2vdf -quiet -ts ${i} -varname W -ncdfvar W -dimnames Z:Y:X -cnstnames t -cnstvals ${time} $vdf $ncdf
 i=$(($i + 1))
 time=$(($time + 1))
done
