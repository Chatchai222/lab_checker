#! /usr/bin/bash
#apple=$(gcc -pass-exit-codes ./Home/Labs/Lab2/560003/Lab23.c -o ./Home/Labs/Lab2/560003/Lab23)
#echo $?

#if $(gcc ./Home/Labs/Lab2/560003/Lab23.c -o ./Home/Labs/Lab2/560003/Lab23); then 
#echo "Success!";
#else 
#echo "Failure"; 
#fi

#student_file_paths=./Home/Labs/Lab2/*/Lab23.c
#for each_file_path in $student_file_paths
#  do
#    echo $each_file_path
#done

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

function get_all_c_file_paths(){
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

function create_result_file(){
  result_directory_path=$1
  lab_number=$2
  question_number=$3
  
  touch ${result_directory_path}/resultLab${lab_number}${question_number}.txt
}

function write_student_id_and_score_to_result_file(){
  result_file_path=$1
  student_id_and_score_array=$2
  
  # Clearing file content
  $(echo "" > $result_file_path)
  
  # Writing to file
  printf "%s\n" ${student_id_and_score_array[@]} > $result_file_path
}

#get_c_file_score ./Home/Labs/Lab2/560001/Lab23.c 56
#echo "my score is $?"

#get_student_id ./Home/Labs/Lab2/560003/Lab23.c

#student_id_and_score=$(get_student_id_and_score ./Home/Labs/Lab2/560002/Lab23.c 56)
#echo "student id and score is $student_id_and_score"

#get_all_c_file_paths . 2 3

#create_result_file ./Results 2 3

#write_student_id_and_score_to_result_file ./Results/resultLab23.txt "apple banana"



echo "End of test_code.sh"



