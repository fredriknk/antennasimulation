startL3=745
stopL3=755
numsL3=5

startL6=155
stopL6=165
numsL6=5

startW1=20
stopW1=25
numsW1=5

sbatch antenna.SLURM.sh 740 745 5 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1

sbatch antenna.SLURM.sh 746 750 5 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1

sbatch antenna.SLURM.sh 751 755 5 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1