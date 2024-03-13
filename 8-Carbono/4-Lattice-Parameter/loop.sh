#!/bin/bash
parameterexp=3.566
step=0.02
start=$(echo "scale=4; $parameterexp-$step*10"| bc)
end=$(echo "scale=4; $parameterexp+$step*10"| bc)

symbol="c"
parameter=3.566
atom="C"
weight=12.011
pseudo="C.pbe-n-rrkjus_psl.1.0.0.UPF"
position1=$(echo "scale=4;$parameter/2" | bc)
position2=$(echo "scale=4;$parameter/4" | bc)
position3=$(echo "scale=4;(3/4)*$parameter" | bc)
ecutwfc=80
n=7
ecutrho=$(echo "scale=2; $n*$ecutwfc" | bc)

for parameter in $(LANG=en_US seq $start $step $end)
do
position=$(echo "scale=4;$parameter/2" | bc)

cat >$symbol-$parameter.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$symbol-$parameter' ,
verbosity = 'high'
/
&SYSTEM
  ibrav = 0,
  nat  = 8,
  ntyp = 1,
  ecutwfc = $ecutwfc,
  ecutrho=  $ecutrho,
  occupations='smearing',
  smearing='mv',
  degauss=0.02,
  /
&ELECTRONS
  electron_maxstep = 400,
  conv_thr = 1.0d-6
  diagonalization  = 'david'
/
ATOMIC_SPECIES
$atom   $weight   $pseudo 
ATOMIC_POSITIONS (angstrom)
$atom   0.0000  0.0000  0.0000	
$atom   $position1  $position1  0.0000
$atom   0.0000  $position1  $position1
$atom   $position1  0.0000  $position1 
$atom   $position2  $position2  $position2
$atom   $position3  $position3  $position2
$atom   $position2  $position3  $position3
$atom   $position3  $position2  $position3
CELL_PARAMETERS {angstrom}
   $parameter  0.00  0.00	
   0.00  $parameter  0.00	
   0.00  0.00  $parameter
K_POINTS automatic
8  8  8  0  0  0 
!
echo "a=$parameter" ; 
done
