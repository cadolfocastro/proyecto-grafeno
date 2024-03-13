#!/bin/bash
PRE_FIX="mpirun -np 6"
QE="pw.x"
name=sixhollow

for i in 5.0 4.5 4.0 3.5 3.0 2.8 2.6 2.4 2.2 2.0 1.8 1.4
do
echo "calculo para energias = $i Ry"

#distance_Z=$i

cat >$name.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$name' ,
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
H       3.321910016   4.9816903105   $i
H       4.073982034   4.9816903105   $i
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
2  2  1  0  0  0 
!

$PRE_FIX $QE -in $name.in > $name.out
E=`grep ! $name.out | awk '{print $5}' `

echo "$i  $E" >> curva$name.dat

done


#ESTO EJECUTA LOS .in una vez creados y crea los .out

	#for i in 5.0 4.5 4.0 3.5 3.0 2.8 2.6 2.4 2.2 2.0 1.8 1.4
	#do
	#distance_Z=$i
	#mpirun -np 5 pw.x  -inp distance-$distance_Z.in > distance-$distance_Z.out
	#done

#



#Después de que se terminen de ejecutar todos los .in, busca en la siguiente carpeta el otro .sh para ejecutarlo como si fuera todo un código en cadena

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/4-bridge2
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/4-bridge2"
	scriptName="loop.sh"
	$scriptPath/$scriptName

#
