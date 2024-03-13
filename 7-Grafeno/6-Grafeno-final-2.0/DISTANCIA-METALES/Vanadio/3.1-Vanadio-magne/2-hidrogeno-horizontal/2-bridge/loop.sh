#!/bin/bash
for i in 2.2 2.0 1.8
do
distance_Z=$i
cat >distance-$distance_Z.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'vanadio-bridge-distance-$distance_Z' ,
verbosity = 'high'
/
&SYSTEM
  ibrav = 4,
  a = 12.32648675,
  c = 10,
  nat  = 52,
  ntyp = 3,
  ecutwfc = 70,
  ecutrho=490,
  occupations='smearing',
  smearing='mv',
  degauss=0.001,
  input_dft='rvv10'
  nspin = 2,
  starting_magnetization(1)=0.5,
  starting_magnetization(2)=0.3,
  starting_magnetization(3)=0.8,
  /
&ELECTRONS
  electron_maxstep = 400,
  conv_thr = 1.0d-6
  diagonalization  = 'david'
/
ATOMIC_SPECIES
H   1.00794    H.pbe-rrkjus.UPF
C   12.01070    C.pbe-n-rrkjus_psl.1.0.0.UPF
V   50.9415    V.pbe-spnl-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS (angstrom)
H       2.7055856785  6.049195377   $i
H       3.4576576965  6.049195377   $i
C        0.000000000   0.000000000   0.000000000
C        0.000000000   1.423340089   0.000000000
C       -1.232648675   2.135010133   0.000000000
C       -1.232648675   3.558350222   0.000000000
C       -2.465297350   4.270020266   0.000000000
C       -2.465297350   5.693360355   0.000000000
C       -3.697946025   6.405030399   0.000000000
C       -3.697946025   7.828370488   0.000000000
C       -4.930594700   8.540040532   0.000000000
C       -4.930594700   9.963380621   0.000000000
C        2.465297350   0.000000000   0.000000000
C        2.465297350   1.423340089   0.000000000
C        1.232648675   2.135010133   0.000000000
C        1.232648675   3.558350222   0.000000000
C        0.000000000   4.270020266   0.000000000
C        0.000000000   5.693360355   0.000000000
C       -1.232648675   6.405030399   0.000000000
C       -1.232648675   7.828370488   0.000000000
C       -2.465297350   8.540040532   0.000000000
C       -2.465297350   9.963380621   0.000000000
C        4.930594700   0.000000000   0.000000000
C        4.930594700   1.423340089   0.000000000
C        3.697946025   2.135010133   0.000000000
C        3.697946025   3.558350222   0.000000000
C        2.465297350   4.270020266   0.000000000
V        2.465297350   5.693360355   0.000000000
C        1.232648675   6.405030399   0.000000000
C        1.232648675   7.828370488   0.000000000
C        0.000000000   8.540040532   0.000000000
C        0.000000000   9.963380621   0.000000000
C        7.395892050   0.000000000   0.000000000
C        7.395892050   1.423340089   0.000000000
C        6.163243375   2.135010133   0.000000000
C        6.163243375   3.558350222   0.000000000
C        4.930594700   4.270020266   0.000000000
C        4.930594700   5.693360355   0.000000000
C        3.697946025   6.405030399   0.000000000
C        3.697946025   7.828370488   0.000000000
C        2.465297350   8.540040532   0.000000000
C        2.465297350   9.963380621   0.000000000
C        9.861189400   0.000000000   0.000000000
C        9.861189400   1.423340089   0.000000000
C        8.628540725   2.135010133   0.000000000
C        8.628540725   3.558350222   0.000000000
C        7.395892050   4.270020266   0.000000000
C        7.395892050   5.693360355   0.000000000
C        6.163243375   6.405030399   0.000000000
C        6.163243375   7.828370488   0.000000000
C        4.930594700   8.540040532   0.000000000
C        4.930594700   9.963380621   0.000000000
K_POINTS automatic
1  1  1  0  0  0 
!
echo "a=$i";
done

for i in 2.2 2.0 1.8
do
distance_Z=$i
mpirun -np 6 pw.x  -inp distance-$distance_Z.in > distance-$distance_Z.out
done

cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/DISTANCIA-METALES/3.1-Vanadio-magne/2-hidrogeno-horizontal/3-sixhollow
scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/DISTANCIA-METALES/3.1-Vanadio-magne/2-hidrogeno-horizontal/3-sixhollow"
scriptName="loop.sh"
$scriptPath/$scriptName
