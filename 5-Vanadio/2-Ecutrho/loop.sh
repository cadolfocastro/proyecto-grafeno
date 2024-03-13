#!/bin/bash
for i in 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
do
j=$(echo "scale=2; $i*70" | bc)
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
  ecutrho = $j,
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
V2   1.515  1.515  1.515
CELL_PARAMETERS {angstrom}
   3.03  0.00  0.00	
   0.00  3.03  0.00	
   0.00  0.00  3.03
K_POINTS automatic
8  8  8  1  1  1
!
echo "a=$i" ; 
done

