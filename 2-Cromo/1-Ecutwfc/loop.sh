#!/bin/bash
for i in 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110
do
cat >cr-$i.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'cr-$i' ,
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 2,
  ecutwfc = $i,
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

