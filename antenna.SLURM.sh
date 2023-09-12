#!/bin/bash
## Job name:
#SBATCH --job-name=Ansim #Name of the job
#
## Wall time limit:
#SBATCH --time=64:00:00
#
####Partition
#SBATCH -w cn-1
## Other parameters:
#SBATCH --cpus-per-task 10 #Number of cpus the job will use
#SBATCH --mem=9G             #Memory RAM
#SBATCH --nodes 1
#SBATCH -o logs/slurm-%x_%j.out    #Standar output message
#SBATCH -e logs/slurm-%x_%j.err    #Standar error message

######Everything below this are the job instructions######

echo "I am running on the NODE $SLURM_NODELIST"
echo "I am running with $SLURM_CPUS_ON_NODE cpus"
echo "Starting $SLURM_JOB_ID at"
date

module purge
module load MATLAB/2019b

startL3=$1
stopL3=$2
numsL3=$3

startL6=$4
stopL6=$5
numsL6=$6

startW1=$7
stopW1=$8
numsW1=$9
meshsize=$10

matlab -nodisplay -nosplash -nodesktop -r "IFALOOP($startL3, $stopL3, $numsL3, $startL6, $stopL6, $numsL6, $startW1, $stopW1, $numsW1, $meshsize)"
echo "Ending $SLURM_JOB_ID at"
date