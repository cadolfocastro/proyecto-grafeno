#!/bin/bash
for i in  2.83 2.85 2.87 2.89 2.91 2.93 2.95 2.97 2.99 3.01 3.03 3.05 3.07 3.09 3.11 3.13 3.15 3.17 3.19 3.21 3.23
do
j=$(echo "scale=4; $i/2" | bc)
cat >v-$i.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'v-$i' ,
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 2,
  ecutwfc = 70,
  ecutrho = 420,
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
V1   50.9415    V.pbe-spnl-rrkjus_psl.1.0.0.UPF
V2   50.9415    V.pbe-spnl-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS  (angstrom)
V1   0.000  0.000  0.000	
V2   $j  $j  $j
CELL_PARAMETERS {angstrom}
   $i  0.00  0.00	
   0.00  $i  0.00	
   0.00  0.00  $i
K_POINTS automatic
8  8  8  1  1  1
!
echo "a=$i" ; 
done

