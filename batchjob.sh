startL3=750
stopL3=780
numsL3=10

startL6=160
stopL6=160
numsL6=1

startW1=15
stopW1=24
numsW1=10

startD5=20
stopD5=30
numsD5=10

sbatch antenna.SLURM.sh	701	720	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	$startD5	$stopD5	$numsD5
sbatch antenna.SLURM.sh	721	740	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	$startD5	$stopD5	$numsD5
sbatch antenna.SLURM.sh	741	760	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	$startD5	$stopD5	$numsD5
sbatch antenna.SLURM.sh	761	780	$numsL3	$startL6	$stopL6	$numsL6	$startW1	$stopW1	$numsW1	$startD5	$stopD5	$numsD5
