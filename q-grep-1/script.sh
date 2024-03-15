#!/bin/bash

xargs file -i | grep text/x-shellscript | cut -d":" -f1 | sort

# while read -r line; do
#   file -i $line | grep text/x-shellscript | cut -d":" -f1
# done | sort
