#!/usr/bin/env bash

#Author: Edward Fernández B
#Description: Script to clone project code and setup all enviroments (front/back) 
#             with docker-engine and docker-compose binaries.

# Steps: 
# 1- Clone this project
# 2- Execute chmod u+x ./diocesanSetUp.sh && ./diocesanSetUp.sh

# First, clone both repositories (front/back) in current directory.
# Execute containersUp to execute both docker-compose.yml inside ./diocesan-back and ./diocesan-front
# Each environment will be connected through the same bridge network.


readonly FRONT_REPOSITORY="";
readonly BACK_REPOSITORY="";
readonly DATE_TIME=`date +%Y%m%d_%H:%M`;
readonly LOG_FILE=$( echo $0 | cut -d'/' -f2 | head -c 13 ; echo _$DATE_TIME.log );
readonly BLOCK_FILE=".block";

blockProcess()
{
  echo "1" > $BLOCK_FILE;
}

unBlockProcess()
{
  echo "0" > $BLOCK_FILE;
}

# 1st param is the message to log file. 
# 2nd param is to know if we need to put the message to stdout.
exceptions()
{
  if [ -n "$2" ] && [ "$2" -eq 1 ];then
    echo $1;
  fi

  echo $1 >> $LOG_FILE;
}

cloneRepositories()
{
  local _binary=$(which git);

  case $? in
    0)
      echo "Clone tasks!";
      ;;
    1)
      exceptions "Please, install GIT package in your system." 1; exit 1;
      ;;
  esac
  

}

#setUpBack(){}
#setUpFront(){}

containersUp()
{
  local _dockerEngineBinary=$(which docker);
  local _dockerComposeBinary=$(which docker-compose);

  if [ -z $_dockerEngineBinary ] || [ -z $_dockerComposeBinary ];then
    exceptions "Please install docker and docker-compose in your system." 1; exit 1;
  fi

  

}


run()
{  
  blockProcess;
  echo "RUN method!";
  sleep 15;

  unBlockProcess;
}


blockStatus=`cat $BLOCK_FILE`;

case $blockStatus in
  0)
    run;
    ;;
  1)
    exceptions "Proceso bloqueado, en ejecución. [$DATE_TIME]" 1; exit 1;
    ;;
esac