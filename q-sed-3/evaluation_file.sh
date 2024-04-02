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
  if diff <("./script.sh" < "$f" | col) <(col < "$output"); then
    echo "passed!"
    ((passed++))
  else
    echo "failed :("
  fi
  ((tc++))
done
if [[ $passed -eq $((tc - 1)) ]]; then
  echo "All test cases passed!"
else
  echo "Some test cases failed"
  exit 1
fi
