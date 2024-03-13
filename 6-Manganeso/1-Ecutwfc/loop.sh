#!/bin/bash
start=10
end=110
for i in $(seq $start 5 $end)
do
symbol="mn"
parameter=8.91
position=$(echo "scale=4;$parameter/2" | bc)
atom1="Mn1"
atom2="Mn2"
weight=54.938044
pseudo="Mn.pbe-spn-rrkjus_psl.0.3.1.UPF"
cat >$symbol-$i.in << !

&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$symbol-$i' ,
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 2,
  ecutwfc = $i,
  occupations='smearing',
  smearing='methfessel-paxton',
  degauss=0.03,
  nspin = 2,
  starting_magnetization(1)=0.1,
  starting_magnetization(2)=-0.1,
  /
&ELECTRONS
      electron_maxstep = 400,
      conv_thr = 1.0d-6
      diagonalization  = 'david'
/
ATOMIC_SPECIES
$atom1   $weight    $pseudo
$atom2   $weight    $pseudo
ATOMIC_POSITIONS  (angstrom)
$atom1   0.0000  0.0000  0.0000	
$atom2   $position  $position  $position
CELL_PARAMETERS {angstrom}
   $parameter  0.00  0.00	
   0.00  $parameter  0.00	
   0.00  0.00  $parameter
K_POINTS automatic
8  8  8  1  1  1
!
echo "a=$i" ; 
done

