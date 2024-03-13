#!/bin/bash
mpirun -np 6 pw.x  -inp cobre.in > cobre.out
mpirun -np 6 pw.x  -inp vanadio.in > vanadio.out
mpirun -np 6 pw.x  -inp manganeso.in > manganeso.out
mpirun -np 6 pw.x  -inp hierro.in > hierro.out
mpirun -np 6 pw.x  -inp niquel.in > niquel.out

