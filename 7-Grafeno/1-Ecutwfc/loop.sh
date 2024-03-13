#!/bin/bash
start=10
end=110
symbol="gr"
atom="C"
weight=12.0107
pseudo="C.pbe-n-rrkjus_psl.1.0.0.UPF"

for ecutwfc in $(seq $start 5 $end)

do
cat >$symbol-$ecutwfc.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$symbol-$ecutwfc' ,
verbosity = 'high'
/
&SYSTEM
  ibrav = 4,
  a = 2.463,
  c = 10,
  nat  = 2,
  ntyp = 1,
  ecutwfc = $ecutwfc,
  occupations='smearing',
  smearing='mv',
  degauss=0.001,
  /
&ELECTRONS
  electron_maxstep = 400,
  conv_thr = 1.0d-6
  diagonalization  = 'david'
/
ATOMIC_SPECIES
$atom   $weight   $pseudo 
ATOMIC_POSITIONS (crystal)
$atom    0.0000000000    0.0000000000    0.0000000000
$atom    0.3333333333    0.6666666666    0.0000000000
K_POINTS automatic
10  10  1  0  0  0 
!
echo "a=$ecutwfc" ; 
done
