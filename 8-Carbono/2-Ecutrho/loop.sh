#!/bin/bash
start=3
end=17
symbol="c"
parameter=3.566
atom="C"
weight=12.011
pseudo="C.pbe-n-rrkjus_psl.1.0.0.UPF"
position1=$(echo "scale=4;$parameter/2" | bc)
position2=$(echo "scale=4;$parameter/4" | bc)
position3=$(echo "scale=4;(3/4)*$parameter" | bc)
ecutwfc=80
for i in $(seq $start $end)

do
ecutrho=$(echo "scale=2;$i*$ecutwfc"| bc)
cat >$symbol-$i.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$symbol-$i' ,
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
echo "a=$i" ; 
done
