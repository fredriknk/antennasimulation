#!/bin/bash

## Job name:
#SBATCH --job-name=Antenna_test  #Name of the job
#
## Wall time limit:
#SBATCH --time=64:00:00
#
####Partition
#SBATCH -w cn-1
## Other parameters:
#SBATCH --cpus-per-task 10 #Number of cpus the job will use
#SBATCH --mem=12G             #Memory RAM
#SBATCH --nodes 1
#SBATCH -o slurm-%x_%j.out    #Standar output message
#SBATCH -e slurm-%x_%j.err    #Standar error message

######Everything below this are the job instructions######

echo "I am running on the NODE $SLURM_NODELIST"
echo "I am running with $SLURM_CPUS_ON_NODE cpus"
echo "Starting $SLURM_JOB_ID at"
date

module purge
module load MATLAB/2019b

startL3 = 733
stopL3 = 766
numsL3 = 10

startL6= 170
stopL6 = 190
numsL6 = 10

startW1 =50
stopW1 = 70
numsW1 = 10
meshsize =  0.001

matlab -nodisplay -nosplash -nodesktop -r IFALOOP($startL3, $stopL3, $numsL3,$startL6, $stopL6, $numsL6,$startW1, $stopW1, $numsW1, $meshsize), exit

echo "Ending $SLURM_JOB_ID at"
date