#!/bin/bash
for i in 5.0 4.5 4.0 3.5 3.0 2.8 2.6 2.4 2.2 2.0 1.8
do
distance_H1=$i
distance_H2=$(echo $distance_H1 + 0.752072018 | bc)
cat >distance-$distance_H1.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'gr-12' ,
verbosity = 'high'
/
&SYSTEM
  ibrav = 4,
  a = 7.3959,
  c = 10,
  nat  = 20,
  ntyp = 3,
  ecutwfc = 70,
  ecutrho=490,
  occupations='smearing',
  smearing='mv',
  degauss=0.001,
  input_dft='rvv10'
  /
&ELECTRONS
  electron_maxstep = 400,
  conv_thr = 1.0d-6
  diagonalization  = 'david'
/
ATOMIC_SPECIES
H   1.00794    H.pbe-rrkjus.UPF
C   12.0107   C.pbe-n-rrkjus_psl.1.0.0.UPF
Cu  63.546    Cu.pbe-dn-rrkjus_psl.1.0.0.UPF 
ATOMIC_POSITIONS (angstrom)
H        1.8489725125    3.914185244   $distance_H1
H        1.8489725125    3.914185244   $distance_H2
C  0.0000000000    0.0000000000    0.0000000000
C  0.0000000000    1.4233400890    0.0000000000
C -1.2326486750    2.1350101330    0.0000000000
C -1.2326486750    3.5583502220    0.0000000000
C -2.4652973500    4.2700202660    0.0000000000
C -2.4652973500    5.6933603550    0.0000000000
C  2.4652973500    0.0000000000    0.0000000000
C  2.4652973500    1.4233400890    0.0000000000
C  1.2326486750    2.1350101330    0.0000000000
Cu 1.2326486750    3.5583502220    0.0000000000
C  0.0000000000    4.2700202660    0.0000000000
C  0.0000000000    5.6933603550    0.0000000000
C  4.9305947000    0.0000000000    0.0000000000
C  4.9305947000    1.4233400890    0.0000000000
C  3.6979460250    2.1350101330    0.0000000000
C  3.6979460250    3.5583502220    0.0000000000
C  2.4652973500    4.2700202660    0.0000000000
C  2.4652973500    5.6933603550    0.0000000000
K_POINTS automatic
4  4  1  0  0  0 
!
echo "a=$i";
done

for i in 5.0 4.5 4.0 3.5 3.0 2.8 2.6 2.4 2.2 2.0 1.8
do
distance_H1=$i
mpirun -np 6 pw.x  -inp distance-$distance_H1.in > distance-$distance_H1.out
done