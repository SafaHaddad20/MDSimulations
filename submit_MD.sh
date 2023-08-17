#!/bin/bash 


for f in *mae;
do
base=${f%.mae}
        mkdir $base
        cp $base.mae solvate.msj desmond_md_500ns.* $base
        cd $base
        echo entering $base
        /schrodinger2018-4/utilities/multisim -JOBNAME desmond_setup_$base -m solvate.msj $base.mae -o desmond_setup_$base-out.cms -maxjob 1 -WAIT
        /schrodinger2018-4/utilities/multisim -VIEWNAME desmond_md_$base.MDApp -JOBNAME desmond_md_$base -m desmond_md_500ns.msj -c desmond_md_500ns.cfg desmond_setup_$base-out.cms -mode umbrella -set stage[1].set_family.md.jlaunch_opt=["-gpu"] -o desmond_md_$base-out.cms -WAIT
        echo finished $base
        cd ../
done
