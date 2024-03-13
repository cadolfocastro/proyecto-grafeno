#!/bin/bash
mpirun -np 5 pw.x  -inp distance-2.94802.in > distance-2.94802.out

	cd /home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/4-bridge2
	scriptPath="/home/cristian/Escritorio/Proyecto_Grafeno/7-Grafeno/6-Grafeno-final-2.0/3-hidrogeno-horizontal/relax-distance/4-bridge2"
	scriptName="bash.sh"
	$scriptPath/$scriptName

#
