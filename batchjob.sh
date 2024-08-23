#!/bin/bash

b="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[2e-3, 3e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
c="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[3e-3, 4e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
d="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[4e-3, 5e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
e="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[5e-3, 6e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
f="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[6e-3, 7e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
g="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[7e-3, 8e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
h="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[8e-3, 9e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
i="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[9e-3, 10e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"
j="optimizeAntennaMultiVars({'L3','L6','D5','W1','W2','W3'}, {[15e-3, 20.5e-3],[10e-3, 11e-3],[1e-3, 10e-3],[0.15e-3, 1e-3], [0.15e-3, 1e-3], [0.15e-3, 1e-3]}, 'minimum', 's11', 50, 1.2e-3); exit;"

#sbatch antenna.SLURM.sh $a
#sbatch antenna.SLURM.sh $b
#sbatch antenna.SLURM.sh $c
#sbatch antenna.SLURM.sh $d
#sbatch antenna.SLURM.sh $e
#sbatch antenna.SLURM.sh $f
#sbatch antenna.SLURM.sh $g
sbatch antenna.SLURM.sh	$h