startL3=760
stopL3=790
numsL3=20

startL6=160
stopL6=160
numsL6=1

startW1=10
stopW1=24
numsW1=15

startD5=10
stopD5=24
numsD5=15

#						$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	$startD5	$stopD5	$numsD5
sbatch antenna.SLURM.sh	$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	6           10      5
sbatch antenna.SLURM.sh	$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	11          15      5
sbatch antenna.SLURM.sh	$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	16          20      5
sbatch antenna.SLURM.sh	$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	21          25      5
