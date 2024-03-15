#!/bin/bash

# this script will activate the environment of Question Development
# it will also set the environment variable for the current directory
#

QDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
export QDIR

alias batcat="bat --paging=always"

home(){
  cd "$QDIR" || return
}

qeval() { # Usage: qeval [question | all]
  question=$1
  if [[ -z $question ]]; then
    question=$(basename "$PWD")
  fi
  question=$(basename "$question")

  if [ "$question" == "all" ]; then
    for q in "${QDIR}"/q-*; do
      qeval "$(basename "$q")"
      echo "--------------------------------"
    done
  else
    echo "Evaluating question $question"
    if [[ ! -d $QDIR/$question ]]; then
      echo "Question $question does not exist"
      return
    fi
    tc=1
    passed=0
    for f in "${QDIR}/$question"/*.in; do
      echo -n "Test Case $tc: "
      output=${f%.in}.out
      if [[ ! -f $output ]]; then
        echo "Output file for test case $tc does not exist"
        continue
      fi
      if diff <("$QDIR/$question"/script.sh < "$f" | col) <(col < "$output"); then
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
    fi
  fi
}

qshow(){ # Usage qshow question
  question=$1
  if [[ $# -eq 0 ]]; then
    question=$(basename "$PWD")
  fi
  if [[ ! -d $QDIR/$question ]]; then
    echo "Question $question does not exist"
    return
  fi
  if [[ ! -e $QDIR/$question/README.md ]]; then
    echo "No README.md file found for question $question"
  fi
  if [[ ! -r $QDIR/$question/README.md ]]; then
    echo "README.md file for question $question is not readable"
  fi
  batcat $QDIR/$question/README.md

}

# Create testcase's output from input using script.sh
qmake(){ # Usage qmake [question | all ]
  question=$1
  if [[ -z $question || "$question" == "-f" ]]; then
    question=$(basename "$PWD")
  fi
  question=$(basename "$question")

  if [ "$question" == "all" ]; then
    for q in "${QDIR}"/q-*; do
      qmake "$(basename "$q")"
      echo "--------------------------------"
    done
  else
    echo "Creating output files for question $question"
    if [[ ! -d $QDIR/$question ]]; then
      echo "Question $question does not exist"
      return
    fi
    if [[ ! -e $QDIR/$question/script.sh ]]; then
      echo "script.sh file for question $question does not exist"
      return
    fi
    if [[ ! -x $QDIR/$question/script.sh ]]; then
      chmod +x "$QDIR/$question/script.sh"
    fi
    tc=1
    for f in "${QDIR}/$question"/*.in; do
      echo -n "Test Case $tc: "
      output=${f%.in}.out
      if [[ -f $output ]]; then
        echo "Output file for test case $tc already exists"
        continue
      fi
      "$QDIR/$question"/script.sh < "$f" > "$output"
      echo "Output file for test case $tc created"
      ((tc++))
    done
  fi
}

# Create a new question
qnew(){ # Usage qnew question
  question=$1
  while [[ -z $question ]]; do
    read -r -p "Enter question name: " question
  done
  # auto add q- prefix
  if [[ ! $question =~ ^q- ]]; then
    echo "$question -> q-$question"
    question="q-$question"
  fi
  # auto add numeric suffix
  if [[ ! $question =~ [0-9]$ ]]; then
    echo "$question -> $question-1"
    question="$question-1"
  fi
  # check if question already exists, then auto increment
  if [[ -d $QDIR/$question ]]; then
    qlast=$(ls -d "$QDIR/${question%-[0-9]}-"* | xargs -I {} basename {} | sort -V | tail -n 1)
    qlast_number=${qlast##*-}
    question="${question%-*}-$((qlast_number + 1))"
    echo "Question already exists, creating new question $question"
  fi
  mkdir -p "$QDIR/$question"
  touch "$QDIR/$question/README.md"
  touch "$QDIR/$question/script.sh"
  chmod +x "$QDIR/$question/script.sh"
  echo "Question $question created"
  cd "$QDIR/$question" || return
}

qqedit(){ # Usage qqedit question
  question=$1
  if [[ $# -eq 0 ]]; then
    question=$(basename "$PWD")
  fi
  if [[ ! -d $QDIR/$question ]]; then
    echo "Question $question does not exist"
    return
  fi
  if [[ ! -e $QDIR/$question/README.md ]]; then
    echo "No README.md file found for question $question"
  fi
  if [[ ! -r $QDIR/$question/README.md ]]; then
    echo "README.md file for question $question is not readable"
  fi
  cd "$QDIR/$question" || return
  $EDITOR README.md
}

qsedit(){ # Usage qsedit question
  question=$1
  if [[ $# -eq 0 ]]; then
    question=$(basename "$PWD")
  fi
  if [[ ! -d $QDIR/$question ]]; then
    echo "Question $question does not exist"
    return
  fi
  if [[ ! -e $QDIR/$question/script.sh ]]; then
    echo "No script.sh file found for question $question"
  fi
  if [[ ! -r $QDIR/$question/script.sh ]]; then
    echo "script.sh file for question $question is not readable"
  fi
  cd "$QDIR/$question" || return
  $EDITOR script.sh

}
