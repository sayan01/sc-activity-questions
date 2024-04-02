#!/bin/bash
test_dir="/opt/se2001/$(basename "$PWD")"
tc=1
passed=0
for f in "$test_dir"/*.in; do
  echo -n "Test Case $tc: "
  output=${f%.in}.out
  if [[ ! -f $output ]]; then
    echo "Output file for test case $tc does not exist"
    continue
  fi
  if [[ -e "$test_dir/env.sh" ]]; then
    # shellcheck disable=1091
    source "$test_dir/env.sh"
  fi
  ((tc++))
  while read -r output expected; do
    if [[ $(bc <<< "( $output - $expected ) / $expected < 0.01") -eq 0 ]]; then
      echo "failed :("
      continue 2
    fi
  done < <(paste <(./script.sh < "$f" | col) <(col < "$output") )
  echo "passed!"
  ((passed++))
done
if [[ $passed -eq $((tc - 1)) ]]; then
  echo "All test cases passed!"
else
  echo "Some test cases passed $passed / $((tc - 1))"
  exit 1
fi
