#!/bin/bash
start=5
end=20
symbol="gr"
atom="C"
weight=12.0107
pseudo="C.pbe-n-rrkjus_psl.1.0.0.UPF"
ecutwfc=70
n=7
ecutrho=$(echo "scale=2; $n*$ecutwfc" | bc)
kpoints=12
vacuum=12

cat >$symbol-relax.in << !
&CONTROL
calculation = 'vc-relax' ,
restart_mode = 'from_scratch' ,
outdir = '/tmp' ,
pseudo_dir = '/home/cristian/Escritorio/Proyecto_Grafeno/pseudopotenciales', 
prefix = '$symbol-relax' ,
verbosity = 'high'
forc_conv_thr=1.0d-4
etot_conv_thr=1.0d-6
/
&SYSTEM
  ibrav = 4,
  a = 2.463,
  c = $vacuum,
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
  mixing_mode      = 'plain'
  mixing_beta      = 0.2D0
  diagonalization  = 'david'
  startingwfc      = 'atomic+random'
/
&IONS
ion_dynamics      = 'bfgs'
/
&CELL
  press_conv_thr=0.5D0
  cell_dynamics='bfgs',
  cell_dofree='2Dxy'
/
ATOMIC_SPECIES
$atom   $weight   $pseudo 
ATOMIC_POSITIONS (crystal)
$atom    0.0000000000    0.0000000000    0.0000000000
$atom    0.3333333333    0.6666666666    0.0000000000
K_POINTS automatic
$kpoints  $kpoints  1  0  0  0 
!
