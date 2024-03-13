#!/bin/bash
for i in 0.01 0.03 0.05 0.07 0.09 0.11
do
cat >degauss-$i.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'degauss-$i' ,
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 2,
  ecutwfc=80,
  ecutrho=800,
  occupations='smearing',
  smearing='gaussian',
  degauss=$i,
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
10  10  10  1  1  1
!
echo "a=$i" ; 
done

