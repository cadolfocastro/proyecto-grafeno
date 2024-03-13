#!/bin/bash
mpirun -np 5 pw.x  -inp distance-2.75422.in > distance-2.75422.out

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/2-hidrogeno-vertical/relax-distance/3-sixhollow
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/2-hidrogeno-vertical/relax-distance/3-sixhollow"
	scriptName="bash.sh"
	$scriptPath/$scriptName

#
