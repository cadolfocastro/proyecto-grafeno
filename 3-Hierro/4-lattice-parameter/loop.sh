#!/bin/bash
parameterexp=2.86
step=0.02
start=$(echo "scale=4; $parameterexp-$step*10"| bc)
end=$(echo "scale=4; $parameterexp+$step*10"| bc)

symbol="fe"
atom1="Fe1"
atom2="Fe2"
weight=55.845
ecutwfc=70
n=7
ecutrho=$(echo "scale=2;$n*$ecutwfc"| bc)
pseudo="Fe.pbe-spn-rrkjus_psl.1.0.0.UPF"

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
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 2,
  ecutwfc = $ecutwfc,
  ecutrho = $ecutrho,
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
echo "a=$parameter" ; 
done
