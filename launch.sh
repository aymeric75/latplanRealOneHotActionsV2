#!/bin/bash

# ###############################
# ## BLOCKSWORLD

# exec 1>blocks-full-repr.out 2>blocks-full-repr.err

# task="blocks"
# type="cylinders-4-flat"
# width_height=""
# nb_examples="20000"
# #suffix="with" # = with author's weight, no noisy test init/goal
# suffix="without" # = without author's weight, no noisy test init/goal
# # suffix="noisywith"
# # suffix="noisywithout"
# baselabel="blocks_"$suffix
# after_sample="blocks_cylinders-4-flat_20000_CubeSpaceAE_AMA4Conv_kltune2"
# pb_subdir="prob-cylinders-4"

# conf_folder="blocks-full-repr"
# #conf_folder="05-06T11:21:55.052SEED1INVSDIFFSEED"
# #conf_folder="05-06T11:21:55.052SEED1INVSSAMESEED"
# #conf_folder="05-06T11:21:55.052SEED1"

# # SEED1 = 42, SEED2 = 43
# label="blocks_877"


# #################
# ## SOKOBAN

# exec 1>sokoban.out 2>sokoban.err

# # sokoban 5 9

# task="sokoban"
# type="sokoban_image-20000-global-global-2-train"
# width_height=""
# nb_examples="20000"
# suffix="without"
# baselabel="sokoban"
# after_sample="sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2"
# pb_subdir="sokoban-2-False"

# label=sokoban_without_609
# # label=sokoban_without_372WITHVARS

# conf_folder="sokoban"



#################
## HANOI

exec 1>hanoi-4-4-TEST-GREY.out 2>hanoi-4-4-TEST-GREY.err

# hanoi 5 9

task="hanoi"
#type="mnist"
width_height="4 4"
#width_height="4 4"
nb_examples="5000"
#suffix="with" # = with author's weight, no noisy test init/goal
suffix="without" # = without author's weight, no noisy test init/goal
# suffix="noisywith"
# suffix="noisywithout"
baselabel="mnist_"$suffix
after_sample="hanoi_4_4_5000_CubeSpaceAE_AMA4Conv"
#pb_subdir="puzzle-mnist-3-3"

conf_folder="hanoi-4-4-with_prering-test-grey"




# #################
# ## PUZZLE MNIST

# exec 1>8-mnist-one-action-really-all-examples-Beta_a10k.out 2>8-mnist-one-action-really-all-examples-Beta_a10k.err


# task="puzzle"
# type="mnist"
# width_height="3 3"
# #width_height="4 4"
# nb_examples="5000"
# #suffix="with" # = with author's weight, no noisy test init/goal
# suffix="without" # = without author's weight, no noisy test init/goal
# # suffix="noisywith"
# # suffix="noisywithout"
# baselabel="mnist_"$suffix
# after_sample="puzzle_mnist_3_3_5000_CubeSpaceAE_AMA4Conv_kltune2"
# pb_subdir="puzzle-mnist-3-3"

# #conf_folder="8-mnist-one-action"
# conf_folder="8-mnist-one-action-really-all-examples-Beta_a10k"


#############################################

pwdd=$(pwd)

problem_file="ama3_samples_${after_sample}_logs_${conf_folder}_domain_blind_problem.pddl"
domain_dir=samples/$after_sample/logs/$conf_folder
domain_file=$domain_dir/domain.pddl

problems_dir=problem-generators/backup-propositional/vanilla/$pb_subdir


./train_kltune.py learn $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $conf_folder


exit 0