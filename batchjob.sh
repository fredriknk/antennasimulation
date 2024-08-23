#!/bin/bash

b="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'},{[14e-3,20.5e-3],[2e-3,4e-3],[1e-3,10e-3],[0.15e-3,1e-3],[0.15e-3,1e-3],[0.15e-3,1e-3]},'minimum','s11',50,1.2e-3);exit;"
c="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'},{[13e-3,20.5e-3],[4e-3,8e-3],[1e-3,10e-3],[0.15e-3,1e-3],[0.15e-3,1e-3],[0.15e-3,1e-3]},'minimum','s11',50,1.2e-3);exit;"
d="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'},{[12e-3,20.5e-3],[8e-3,10e-3],[1e-3,10e-3],[0.15e-3,1e-3],[0.15e-3,1e-3],[0.15e-3,1e-3]},'minimum','s11',50,1.2e-3);exit;"
e="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'},{[10e-3,20.5e-3],[10e-3,12e-3],[1e-3,10e-3],[0.15e-3,1e-3],[0.15e-3,1e-3],[0.15e-3,1e-3]},'minimum','s11',50,1.2e-3);exit;"

sbatch antenna.SLURM.sh $b
sbatch antenna.SLURM.sh $c
sbatch antenna.SLURM.sh $d
sbatch antenna.SLURM.sh $e