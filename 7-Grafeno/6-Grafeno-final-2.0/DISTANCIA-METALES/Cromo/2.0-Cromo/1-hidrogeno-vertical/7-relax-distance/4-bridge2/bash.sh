#!/bin/bash
mpirun -np 5 pw.x  -inp distance-2.72992.in > distance-2.72992.out

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/2-hidrogeno-vertical/relax-distance/5-baricentro
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/2-hidrogeno-vertical/relax-distance/5-baricentro"
	scriptName="bash.sh"
	$scriptPath/$scriptName

#
