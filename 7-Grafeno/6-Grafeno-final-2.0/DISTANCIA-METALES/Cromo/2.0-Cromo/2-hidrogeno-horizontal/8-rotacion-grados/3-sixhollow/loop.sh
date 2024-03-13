#!/bin/bash
PRE_FIX="mpirun -np 6"
QE="pw.x"
pi=3.1415926535897
z=2.948024288
# posiciones del centro de masas del H2
xo=3.697946025000000
yo=4.9816903105

dhh=0.752072018000000  # vertical, para horizontal: dhh=0.0  
for theta in 0 15 30 45 60
do
x1=`bc -l <<!
  scale=6
  ${xo}+0.5*${dhh}*c(${theta}*${pi}/180)
!`

y1=`bc -l <<!
  scale=6
  ${yo}+0.5*${dhh}*s(${theta}*${pi}/180)
!`

x2=`bc -l <<!
  scale=6
  ${xo}-0.5*${dhh}*c(${theta}*${pi}/180) 
!`

y2=`bc -l <<!
  scale=6
  ${yo}-0.5*${dhh}*s(${theta}*${pi}/180)
!`


cat >rotate-$theta.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = 'rotate-$theta' ,
verbosity = 'high'
/
&SYSTEM
  ibrav = 4,
  a = 12.32648675,
  c = 15,
  nat  = 52,
  ntyp = 2,
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
C   12.01070    C.pbe-n-rrkjus_psl.1.0.0.UPF 
ATOMIC_POSITIONS (angstrom)
H        $x1 $y1 $z
H        $x2 $y2 $z
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
C        2.465297350   5.693360355   0.000000000
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
echo "Posicion para $theta grados"
echo "H   ${x1}  ${y1}  0.0"
echo "H   ${x2}  ${y2}  0.0"

done

for theta in 0 15 30 45 60
do
$PRE_FIX $QE -in rotate-$theta.in > rotate-$theta.out
done

cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/8-rotacion-grados/4-bridge2
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/8-rotacion-grados/4-bridge2"
	scriptName="loop.sh"
	$scriptPath/$scriptName
