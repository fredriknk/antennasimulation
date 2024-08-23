#!/bin/bash

b="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'},{[10e-3,20.5e-3],[2e-3,12e-3],[1e-3,12e-3],[0.15e-3,1e-3],[0.15e-3,1e-3],[0.15e-3,1e-3]},'minimum','s11',50,1.2e-3);exit;"
sbatch antenna.SLURM.sh $b