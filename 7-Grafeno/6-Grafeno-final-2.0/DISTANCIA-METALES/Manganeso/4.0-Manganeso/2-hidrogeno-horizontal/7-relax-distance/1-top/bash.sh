#!/bin/bash
mpirun -np 5 pw.x  -inp distance-3.13336.in > distance-3.13336.out

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/2-bridge
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/2-bridge"
	scriptName="bash.sh"
	$scriptPath/$scriptName

#
