# System Commands (SE2001) Activity Questions

This repository contains some additional activity
questions for practice for the System Commands
([SE2001](https://study.iitm.ac.in/ds/course_pages/BSSE2001.html)) course.

## How to use this repository?

1. Clone this repository to your local machine.
2. Open the terminal and navigate to the directory where you have cloned the repository.
3. Source the `activate.sh` script to activate the environment.
4. Go inside each question's directory and type `qshow` to see the question.
5. Write the answer in a file called `script.sh`.
6. Run `qeval` in that folder to check your answer.

## How to develop this repository?

1. Clone this repository to your local machine.
2. Open the terminal and navigate to the directory where you have cloned the repository.
3. Source the `activate.sh` script to activate the environment.
4. Type `qnew type_of_question` to create a new question. If you type `qnew awk`,
   it will automatically create `q-awk-4` directory with the necessary files, if
   the last question was `q-awk-3`.
5. Type `qqedit` to edit the README.md file to add the question.
6. Type `qsedit` to edit the `script.sh` file to add the solution.
7. Create your test cases of the format `*.in` in the directory.
8. Type `qmake` to create the output files for the test cases of format `*.out`.
9. If you change the solution, type `qeval` to check if the solution is correct.
   or remove the `*.out` files and type `qmake` to create the output files again.

You can also run `qeval all` to check all the questions at once.

All the commands can be also run from other directories by providing
the name of the question as an argument. For example, `qshow q-awk-4`.
