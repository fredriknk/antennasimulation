startL3=700
stopL3=733
numsL3=10

startL6=170
stopL6=190
numsL6=10

startW1=50
stopW1=70
numsW1=10
meshsize=0.0012

sbatch antenna.SLURM.sh 700 733 5 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 $meshsize
sbatch antenna.SLURM.sh 734 766 5 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 $meshsize
sbatch antenna.SLURM.sh 767 800 5 $startL6 $stopL6 $numsL6 $startW1 $stopW1 $numsW1 $meshsize