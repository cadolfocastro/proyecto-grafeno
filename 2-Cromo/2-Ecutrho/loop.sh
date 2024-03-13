#!/bin/bash
for i in 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
do
j=$(echo "scale=2; $i*80" | bc)
cat >cr-$j.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'cr-$j' ,
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 2,
  ecutwfc=80,
  ecutrho=$j,
  occupations='smearing',
  smearing='methfessel-paxton',
  degauss=0.02,
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
Cr1   51.9961    Cr.pbe-spn-rrkjus_psl.1.0.0.UPF
Cr2   51.9961    Cr.pbe-spn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS  (angstrom)
Cr1   0.000  0.000  0.000	
Cr2   1.455  1.455  1.455
CELL_PARAMETERS {angstrom}
   2.91  0.00  0.00	
   0.00  2.91  0.00	
   0.00  0.00  2.91
K_POINTS automatic
8  8  8  1  1  1
!
echo "a=$i" ; 
done

