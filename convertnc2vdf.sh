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
xvel="U"
buoy="B"
while getopts hx:y:z:n:s:l:i:o:U:B: opt
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
                  echo "$Nx points in the X direction";;
            y)    Ny=$OPTARG
                  echo "$Ny points in the Y direction";;
            z)    Nz=$OPTARG
                  echo "$Nz points in the Z direction";;
            U)    xvel=$OPTARG
                  echo "x velocity is calculated $xvel";;
            B)    buoy=$OPTARG
                  echo "buoyancy is calculated $buoy";;
            h)    echo "This script converts a netcdf file into a VAPOR data collection."
                  echo "Assumes the netcdf file has variables U, V, W, and b with dimensions X, Y, Z and t where X and Y are periodic."
                  echo "It uses vdfcreate to setup the data collecton and ncdf2vdf for the conversion of each variable at each time step.\n"
                  echo "Usage: $0 [-x # X points] [-y # of Y points] [-z # of Z points] [-U x-velocity input variable] [-V y-velocity input variable] [-W z-velocity input variable] [-b buoyancy input variable] [-n # of time steps] [-s starting step] [-l refinement level] [-i input.nc] [-o output.vdf]"
                  echo "Default configuration:$0 -x $Nx -y $Ny -z $Nz -U $xvel -V $yvel -Z $zvel -b $bouy -n $n -s $i -l $l -i $ncdf -o $vdf"
                  exit 1;;
            \?)   echo "Usage: $0 [-x # X points] [-y # of Y points] [-z # of Z points] [-U x-velocity input variable] [-V y-velocity input variable] [-W z-velocity input variable] [-b buoyancy input variable] [-n # of time steps] [-s starting step] [-l refinement level] [-i input.nc] [-o output.vdf]"
                  echo "Default configuration:$0 -x $Nx -y $Ny -z $Nz -U $xvel -V $yvel -Z $zvel -b $bouy -n $n -s $i -l $l -i $ncdf -o $vdf"
                  exit 1;;
      esac
done
time=$i
i=0
vapor-setup.sh
ncpdq -a t,Z,Y,X -d t,$time,$(($n-1)) $ncdf reorder$ncdf
ncap2 -v -s 't=t;X=X;Y=Y;Z=Z;V=V;W=W' -s "B=$buoy" -s "U=$xvel" reorder$ncdf fixed$ncdf
rm reorder$ncdf
vdfcreate -dimension ${Nx}x${Ny}x${Nz} -numts $n -level $l -periodic 1:1:0 -vars3d U:V:W:B $vdf
while [ $i -lt $n ]
do
 echo "converting netcdf step $time to vdc step $i"
 ncdf2vdf -quiet -ts ${i} -varname B -ncdfvar B -dimnames X:Y:Z -cnstnames t -cnstvals ${time} $vdf fixed$ncdf
 ncdf2vdf -quiet -ts ${i} -varname U -ncdfvar U -dimnames X:Y:Z -cnstnames t -cnstvals ${time} $vdf fixed$ncdf
 ncdf2vdf -quiet -ts ${i} -varname V -ncdfvar V -dimnames X:Y:Z -cnstnames t -cnstvals ${time} $vdf fixed$ncdf
 ncdf2vdf -quiet -ts ${i} -varname W -ncdfvar W -dimnames X:Y:Z -cnstnames t -cnstvals ${time} $vdf fixed$ncdf
 i=$(($i + 1))
 time=$(($time + 1))
done
rm fixed$ncdf
