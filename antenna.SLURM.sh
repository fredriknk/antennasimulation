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
#SBATCH --cpus-per-task 12 #Number of cpus the job will use
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

BstartL3=$1
BstopL3=$2
BnumsL3=$3
BstartL6=$4
BstopL6=$5
BnumsL6=$6
BstartW1=$7
BstopW1=$8
BnumsW1=$9
BstartD5=${10}
BstopD5=${11}
BnumsD5=${12}

echo params = $BstartL3, $BstopL3, $BnumsL3, $BstartL6, $BstopL6, $BnumsL6, $BstartW1, $BstopW1, $BnumsW1, $BstartD5, $BstopD5, $BnumsD5

matlab -nodisplay -nosplash -nodesktop -r "IFALOOP($BstartL3, $BstopL3, $BnumsL3, $BstartL6, $BstopL6, $BnumsL6, $BstartW1, $BstopW1, $BnumsW1, $BstartD5, $BstopD5, $BnumsD5, 0.0012)"
echo "Ending $SLURM_JOB_ID at"
date