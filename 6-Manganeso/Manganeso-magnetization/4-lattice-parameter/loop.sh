#!/bin/bash
parameterexp=8.91
step=0.02
start=$(echo "scale=4; $parameterexp-$step*10"| bc)
end=$(echo "scale=4; $parameterexp+$step*10"| bc)

symbol="mn"
atom="Mn"
weight=54.938044
ecutwfc=60
pseudo="Mn.pbe-spn-rrkjus_psl.0.3.1.UPF"
n=8
ecutrho=$(echo "scale=2;$n*$ecutwfc"| bc)

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
  ntyp = 1,
  ecutwfc = $ecutwfc,
  ecutrho = $ecutrho,
  occupations='smearing',
  smearing='methfessel-paxton',
  degauss=0.03,
  nspin = 2,
  starting_magnetization(1)=0.7,
  /
&ELECTRONS
      electron_maxstep = 400,
      conv_thr = 1.0d-6
      diagonalization  = 'david'
/
ATOMIC_SPECIES
$atom   $weight    $pseudo
ATOMIC_POSITIONS  (angstrom)
$atom   0.0000  0.0000  0.0000	
$atom   $position  $position  $position
CELL_PARAMETERS {angstrom}
   $parameter  0.00  0.00	
   0.00  $parameter  0.00	
   0.00  0.00  $parameter
K_POINTS automatic
4  4  4  1  1  1
!
echo "a=$parameter" ; 
done
