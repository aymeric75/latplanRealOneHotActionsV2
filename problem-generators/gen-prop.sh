#!/bin/bash

dir=$(dirname $(readlink -ef $0))
# sokoban / PDDLgym needs it
export FF_PATH=$(readlink -ef $dir/../planner-scripts/ff)
export SHELL=/bin/bash

parallel --line-buffer <<EOF

## hanoi 4-4 do not have 14-step optimal plan (less than the graph diameter)
$dir/generate-propositional.py 7  20 hanoi 4 4


EOF

echo "done!"
