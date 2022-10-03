#!/bin/bash

function get_c_file_score(){
  c_file_path=$1
  c_file_expected_exit_code=$2
  
  c_file_executable_path=${c_file_path%.c}
  
  #echo "c file path: $c_file_path"
  #echo "c file executable path: $c_file_executable_path"
  
  gcc $c_file_path -o $c_file_executable_path
  gcc_exit_code=$?
  
  #echo "gcc exit code: $gcc_exit_code"
  
  # C file cannot compile
  if [ $gcc_exit_code == 1 ] 
  then
    #echo "returning 1, C file cannot compile"
    return 1
  fi
  
  # Execute the created executable file
  $c_file_executable_path
  c_file_exit_code=$?
  
  #echo "C file exit code: $c_file_exit_code"
  
  # Check if c file exit code is correct
  if [ $c_file_exit_code == $c_file_expected_exit_code ]
  then
    return 3
  else
    return 2
  fi
 
}

function get_student_id(){
  c_file_path=$1
  
  c_file_path_directory=${c_file_path%/*}
  student_id=${c_file_path_directory##*/}
  output=$student_id
  
  ### DEBUG PURPOSE ONLY ###
  #echo "c file_path: $c_file_path"
  #echo "c_file_path: $c_file_path_directory"
  #echo "student id: $student_id"
  
  echo "$output"
}

function get_student_id_and_score(){
  c_file_path=$1
  c_file_expected_exit_code=$2
  
  get_c_file_score $c_file_path $c_file_expected_exit_code
  c_file_score=$?
  
  student_id=$(get_student_id $c_file_path)
  
  output="$student_id;$c_file_score"
  
  ### FOR DEBUGGING ONLY ###
  #echo "c_file_score: $c_file_score"
  #echo "student id: $student_id"
  #echo "output: $output"
  
  echo "$output"
}

function get_c_file_path_array(){
  project_directory_path=$1
  lab_number=$2
  question_number=$3
  
  expression_to_generate_file_paths="$project_directory_path/Home/Labs/Lab${lab_number}/*/Lab${lab_number}${question_number}.c"
  output=()
  for each_file_path in $expression_to_generate_file_paths
  do
    output+="$each_file_path "
  done
  
  ### DEBUGGING PURPOSE ONLY ###
  #echo "project_directory_path: $project_directory_path"
  #echo "lab_number: $lab_number"
  #echo "question_number: $question_number"
  #for each_output in $output
  #do
  #  echo "$each_output"
  #done
  
  echo "$output"
}

### MAIN PROGRAM STARTS HERE ###
lab_number_and_question_number=$(echo "$1" | tr -dc '0-9'); 
expected_c_file_exit_code=$2

lab_number=${lab_number_and_question_number::-1}
question_number=${lab_number_and_question_number: -1}
project_directory_path=$(dirname $0)


# Getting id and score array
c_file_path_array=$(get_c_file_path_array $project_directory_path $lab_number $question_number)

student_id_and_score_array=()
for c_file_path in $c_file_path_array
do
  each_student_id_and_score=$(get_student_id_and_score $c_file_path $expected_c_file_exit_code)
  student_id_and_score_array+="$each_student_id_and_score "
done
  

# Writing id and score to result file
result_file_path=${project_directory_path}/Home/Results/resultLab${lab_number}${question_number}.txt
touch $result_file_path
printf "%s\n" ${student_id_and_score_array} > $result_file_path

### DEBUGGING ###
echo "lab_number: $lab_number"
echo "question_number: $question_number"
echo "expected_c_file_exit_code: $expected_c_file_exit_code"
echo "project_directory_path: $project_directory_path"
echo "c_file_path_array: "
printf "%s \n" ${c_file_path_array}
echo "student_id_and_score_array: "
printf "%s \n" ${student_id_and_score_array}
echo "result_file_path: $result_file_path"
## END DEBUGGING ###



### MAIN PROGRAM ENDS HERE ###

