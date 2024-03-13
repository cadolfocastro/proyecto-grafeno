#!/bin/bash
start=2
end=15

symbol="mn"
atom="Mn"
weight=54.938044
pseudo="Mn.pbe-spn-rrkjus_psl.0.3.1.UPF"
ecutwfc=70
ecutrho=700
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
  ibrav = 0,
  nat  = 29,
  ntyp = 1,
  ecutwfc = $ecutwfc,
  ecutrho=  $ecutrho,
  occupations='smearing',
  smearing='methfessel-paxton',
  degauss=0.03,
  nspin = 2,
  starting_magnetization(1)=0.7,
  /
&ELECTRONS
      electron_maxstep = 400,
      conv_thr = 1.0d-6
      diagonalization  = 'david'
/
ATOMIC_SPECIES
$atom   $weight    $pseudo
ATOMIC_POSITIONS (crystal)
  Mn      0.00000000000000   0.00000000000000   0.00000000000000
  Mn      0.63574000000000   0.63574000000000   0.63574000000000
  Mn      0.00000000000000   0.00000000000000   0.36426000000000
  Mn      0.00000000000000   0.36426000000000   0.00000000000000
  Mn      0.36426000000000   0.00000000000000   0.00000000000000
  Mn      0.19236000000000   0.19236000000000   0.82084000000000
  Mn      0.37152000000000   0.37152000000000   0.17916000000000
  Mn      0.62848000000000   0.80764000000000   0.00000000000000
  Mn      0.80764000000000   0.62848000000000   0.00000000000000
  Mn      0.82084000000000   0.19236000000000   0.19236000000000
  Mn      0.17916000000000   0.37152000000000   0.37152000000000
  Mn      0.00000000000000   0.62848000000000   0.80764000000000
  Mn      0.00000000000000   0.80764000000000   0.62848000000000
  Mn      0.19236000000000   0.82084000000000   0.19236000000000
  Mn      0.37152000000000   0.17916000000000   0.37152000000000
  Mn      0.80764000000000   0.00000000000000   0.62848000000000
  Mn      0.62848000000000   0.00000000000000   0.80764000000000
  Mn      0.67751000000000   0.67751000000000   0.28588000000000
  Mn      0.39163000000000   0.39163000000000   0.71412000000000
  Mn      0.60837000000000   0.32249000000000   0.00000000000000
  Mn      0.32249000000000   0.60837000000000   0.00000000000000
  Mn      0.28588000000000   0.67751000000000   0.67751000000000
  Mn      0.71412000000000   0.39163000000000   0.39163000000000
  Mn      0.00000000000000   0.60837000000000   0.32249000000000
  Mn      0.00000000000000   0.32249000000000   0.60837000000000
  Mn      0.67751000000000   0.28588000000000   0.67751000000000
  Mn      0.39163000000000   0.71412000000000   0.39163000000000
  Mn      0.32249000000000   0.00000000000000   0.60837000000000
  Mn      0.60837000000000   0.00000000000000   0.32249000000000
CELL_PARAMETERS (angstrom)
  -4.45550000000000   4.45550000000000   4.45550000000000
   4.45550000000000  -4.45550000000000   4.45550000000000
   4.45550000000000   4.45550000000000  -4.45550000000000
K_POINTS automatic
$kpoints  $kpoints  $kpoints  0  0  0
!
echo "a=$kpoints" ; 
done

