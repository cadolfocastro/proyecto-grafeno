#!/bin/bash
mpirun -np 5 pw.x  -inp distance-3.11403.in > distance-3.11403.out

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/3-sixhollow
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/3-sixhollow"
	scriptName="bash.sh"
	$scriptPath/$scriptName

#
