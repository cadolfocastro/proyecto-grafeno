#!/bin/bash
start=2
end=17
symbol="gr"
atom="C"
weight=12.0107
pseudo="C.pbe-n-rrkjus_psl.1.0.0.UPF"
ecutwfc=70
n=7
ecutrho=$(echo "scale=2; $n*$ecutwfc" | bc)
for kpoints in $(seq $start $end)

do

cat >$symbol-$kpoints.in << !
&CONTROL
calculation = 'scf' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$symbol-$kpoints' ,
verbosity = 'high'
/
&SYSTEM
  ibrav = 4,
  a = 2.463,
  c = 10,
  nat  = 2,
  ntyp = 1,
  ecutwfc = $ecutwfc,
  ecutrho=$ecutrho,
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
$kpoints  $kpoints  1  0  0  0 
!
echo "a=$kpoints" ; 
done
