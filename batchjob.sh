startL3=768
stopL3=768
numsL3=1

startL6=160
stopL6=160
numsL6=1

startW1=24
stopW1=24
numsW1=1

startD5=24
stopD5=24
numsD5=1

#						$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	$startD5	$stopD5	$numsD5
sbatch antenna.SLURM.sh	$startL3	$stopL3	$numsL3	$startL6	$stopL6	$numsL6	6	        24      50  	6       	24  	50
