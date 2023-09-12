startL3=768
stopL3=768
numsL3=1

startL6=160
stopL6=160
numsL6=1

startW1=20
stopW1=20
numsW1=1

startD5=25
stopD5=50
numsD5=10


sbatch antenna.SLURM.sh $startL3 $stopL3 $numsL3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 20 30 $numsD5
sbatch antenna.SLURM.sh $startL3 $stopL3 $numsL3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 31 40 $numsD5