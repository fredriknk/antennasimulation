startL3=770
stopL3=780
numsL3=5

startL6=160
stopL6=160
numsL6=1

startW1=20
stopW1=20
numsW1=1

startD5=24
stopD5=24
numsD5=1


sbatch antenna.SLURM.sh 760 770 3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 $startD5 $stopD5 $numsD5
sbatch antenna.SLURM.sh 771 780 3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 $startD5 $stopD5 $numsD5
sbatch antenna.SLURM.sh 781 790 3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 $startD5 $stopD5 $numsD5