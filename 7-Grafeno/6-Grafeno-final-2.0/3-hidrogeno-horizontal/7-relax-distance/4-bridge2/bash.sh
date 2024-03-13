#!/bin/bash
mpirun -np 5 pw.x  -inp distance-3.06797.in > distance-3.06797.out

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/5-baricentro
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/5-baricentro"
	scriptName="bash.sh"
	$scriptPath/$scriptName

#
