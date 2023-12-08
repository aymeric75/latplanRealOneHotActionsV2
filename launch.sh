#!/bin/bash




#################
## HANOI

exec 1>mymnist_hanoi.out 2>mymnist_hanoi.err

# hanoi 5 9

task="hanoi"
#type="mnist"
width_height="5 9"
#width_height="4 4"
nb_examples="5000"
#suffix="with" # = with author's weight, no noisy test init/goal
suffix="without" # = without author's weight, no noisy test init/goal
# suffix="noisywith"
# suffix="noisywithout"
baselabel="mnist_"$suffix
after_sample="puzzle_mnist_3_3_5000_CubeSpaceAE_AMA4Conv_kltune2"
pb_subdir="puzzle-mnist-3-3"

conf_folder="hanoi"




# #################
# ## PUZZLE MNIST

# exec 1>mymnist_49.out 2>mymnist_49.err


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

# conf_folder="49"


##############################################

pwdd=$(pwd)

problem_file="ama3_samples_${after_sample}_logs_${conf_folder}_domain_blind_problem.pddl"
domain_dir=samples/$after_sample/logs/$conf_folder
domain_file=$domain_dir/domain.pddl

problems_dir=problem-generators/backup-propositional/vanilla/$pb_subdir





./train_kltune.py learn $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $conf_folder


exit 0