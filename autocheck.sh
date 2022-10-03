#!/bin/bash

# Getting info from command line argumen
LAB_NUMBER_AND_QUESTION_NUMBER=$(echo "$1" | tr -dc '0-9'); # Trim out the alphabet character except numerics
EXPECTED_OUTPUT=$2

echo "arg1 is $1"
echo "arg2 is $2"

# Extracting info from command line arguments
QUESTION_NUMBER=${LAB_NUMBER_AND_QUESTION_NUMBER: -1} # The space in between the ": -1}" is necessary
LAB_NUMBER=${LAB_NUMBER_AND_QUESTION_NUMBER:0:-1} # String without suffix

echo "Lab number is $LAB_NUMBER"
echo "Question number is $QUESTION_NUMBER"

# Getting all the absolute filepath for each student
PROJECT_FILEPATH=`pwd`
LAB_FILEPATH="${PROJECT_FILEPATH}/Home/Labs/Lab${LAB_NUMBER}"

echo "This script file is at $PROJECT_FILEPATH"
echo "Lab filepath is at $LAB_FILEPATH"

student_directories=()
echo "student directories have: "
for directory in "$LAB_FILEPATH"/* ; do
  student_directories+=($directory)
  echo "$directory"
done

student_c_file_paths=()
echo "student c file paths are: "
for directory in ${student_directories[@]} ; do
  each_student_c_file_path="${directory}/Lab${LAB_NUMBER}${QUESTION_NUMBER}.c" 
  student_c_file_paths+=($each_student_c_file_path)
  echo $each_student_c_file_path
done




echo "End of program"











