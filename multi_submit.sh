#!/bin/bash
export REFINE=1
read -p "Do you want to clear previous data? (y/n)" yn
case $yn in
    [yY] ) echo "Removing data";rm -r /nobackup/rmvn14/thesis/visco-stability/output-*; rm data-cliff-stability/*; break;;
    [nN] ) break;;
esac
set -e
module load aocc/5.0.0
module load aocl/5.0.0
sbcl --dynamic-space-size 16000 --load "build.lisp" --quit
for h in 400
do
    for f in 0.9
    do
        export HEIGHT=$h
        export FLOATATION=$f
        sbatch batch_cliff_stab.sh
    done
done
