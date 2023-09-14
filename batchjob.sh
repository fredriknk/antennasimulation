startL3=768
stopL3=768
numsL3=1

startL6=160
stopL6=160
numsL6=1

startW1=24
stopW1=100
numsW1=100

startD5=25
stopD5=100
numsD5=50

#						$startL3 $stopL3 $numsL3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 startD5	stopD5 	$numsD5
sbatch antenna.SLURM.sh $startL3 $stopL3 $numsL3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 16 		50 		$numsD5
sbatch antenna.SLURM.sh $startL3 $stopL3 $numsL3 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 51 		100 	$numsD5
