#!/bin/bash
for i in 0.5 0.55 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.77 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.9 0.95 1.0 1.1 1.2 1.3 1.5 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
do

cat >H-$i.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = './', 
prefix = 'H-$i' ,
verbosity = 'low'
/
&SYSTEM
  ibrav = 0,
  nat  = 2,
  ntyp = 1,
  ecutwfc = 80,
  ecutrho=800,
  starting_magnetization(1)=0.3,
  occupations='smearing',
  smearing='methfessel-paxton',
  degauss=0.02,
  /
&ELECTRONS
  electron_maxstep = 400,
  conv_thr = 1.0d-6
  diagonalization  = 'cg'
/
ATOMIC_SPECIES
H   1.00794    H.pbe-rrkjus.UPF
ATOMIC_POSITIONS  (angstrom)
H   5  5  5	
H   5  5  $i 
CELL_PARAMETERS {angstrom}
   10.0  0.00  0.00	
   0.00  10.0  0.00	
   0.00  0.00  10.0
K_POINTS gamma
1  1  1  1  1  1   
!
echo "a=$i" ; 
done

