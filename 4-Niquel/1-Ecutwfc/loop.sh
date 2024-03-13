#!/bin/bash
start=10
end=110
symbol="ni"
parameter=3.52
position=$(echo "scale=4;$parameter/2" | bc)
atom1="Ni1";atom2="Ni2";atom3="Ni1";atom4="Ni2"
weight=58.6934
pseudo="Ni.pbe-spn-rrkjus_psl.1.0.0.UPF"

for i in $(seq $start 5 $end)

do
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
  nat  = 4,
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
$atom3   $weight    $pseudo
$atom4   $weight    $pseudo
ATOMIC_POSITIONS  (angstrom)
$atom1   0.0000  0.0000  0.0000	
$atom2   $position  $position  0.0000
$atom3   0.0000  $position  $position
$atom4   $position  0.0000  $position  
CELL_PARAMETERS {angstrom}
   $parameter  0.00  0.00	
   0.00  $parameter  0.00	
   0.00  0.00  $parameter
K_POINTS automatic
8  8  8  1  1  1
!
echo "a=$i" ; 
done

