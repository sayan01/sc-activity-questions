#!/bin/bash

# Solution 1 ----- faster ------------------------------------
xargs file -i | grep text/x-shellscript | cut -d":" -f1 | sort

# Solution 2 ----- slower ------------------------------------
# while read -r line; do
#   file -i $line | grep text/x-shellscript | cut -d":" -f1
# done | sort
