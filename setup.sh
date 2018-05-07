#!/usr/bin/env bash

#Author: Edward Fernández B
#Date: 02/05/2018
# Description:
#   Script to clone project code and setup all enviroments (frontend/backend) 
#   with docker-engine and docker-compose binaries.
                        

# Steps: 
# 1- Clone this project
# 2- Execute chmod u+x ./diocesanSetUp.sh && ./diocesanSetUp.sh

# First, clone both repositories (front/back) in current directory.
# Clone frontend and backend repositories in current directory and rename them with app-backend and app-frontend
# Execute docker-compose to setup docker environment

readonly FLAGS=$1;
readonly RUN_DIRECTORY="local"
readonly DATE_TIME=`date +%Y%m%d_%H:%M`;
readonly LOG_FILE=$( echo $0 | cut -d'/' -f2 | head -c 13 ; echo _$DATE_TIME.log );
readonly BLOCK_FILE_NAME=".block";
readonly FRONTEND_REPOSITORY=$(cat $RUN_DIRECTORY/.env | grep -i frontend_repo | cut -d'=' -f2);
readonly BACKEND_REPOSITORY=$(cat $RUN_DIRECTORY/.env | grep -i backend_repo | cut -d'=' -f2);

blockProcess()
{
  echo "1" > $BLOCK_FILE_NAME;
}

unBlockProcess()
{
  echo "0" > $BLOCK_FILE_NAME;
}

# 1st param is the message to log file. 
# 2nd param is to know if we need to put the message to stdout.
exceptions()
{
  if [ -n "$2" ] && [ "$2" -eq 1 ];then
    echo $1;
  fi

  echo $1 >> $LOG_FILE;
  unBlockProcess;
}

containersUp()
{
  local _dockerEngineBinary=$(which docker);
  local _dockerComposeBinary=$(which docker-compose);

  if [ "$FLAGS" == "devops" ];then
    $RUN_DIRECTORY="devops";
    echo "Executing as devop mode."
  fi

  if [ -z $_dockerEngineBinary ] || [ -z $_dockerComposeBinary ];then
    exceptions "Please, install docker and docker-compose in your system." 1; exit 1;
  fi
  
  cd $RUN_DIRECTORY && $_dockerComposeBinary up -d --build ; cd ..

}

verifyIfExistDevDirs()
{
  find . 2>&1 -type d -name 'app-*' | grep -v 'find:' > /dev/null;
  _result=$?;

  if [ "$_result" -eq 0 ];then
   return 0;
  fi

  return 1;
}

cloneFrontEndAndBackEnd()
{
  local _frontend_directory="app-frontend";
  local _backend_directory="app-backend";
  local _cpBinary=$(which cp);  

  verifyIfExistDevDirs;

  $1 clone $FRONTEND_REPOSITORY $_frontend_directory && $1 clone $BACKEND_REPOSITORY $_backend_directory;

  if [ $? != 0 ];then
    exceptions "There was a problem related repositories clone tasks" 1; exit 1;
  fi

  $_cpBinary $_backend_directory/.env.dist $_backend_directory/.env
  
  return 0;
  
}

clone()
{
  local _binary=$(which git);

  case $? in
    0)
      cloneFrontEndAndBackEnd $_binary;
      ;;
    1)
      exceptions "Please, install GIT package in your system." 1; exit 1;
      ;;
  esac
  

}


run()
{  
  blockProcess;
  verifyIfExistDevDirs;
  case $? in
    0)
      containersUp;
      ;;
    1)
      clone && containersUp;
      ;;
  esac  
  unBlockProcess;
}


blockStatus=`cat $BLOCK_FILE_NAME`;

case $blockStatus in
  0)
    run;
    ;;
  1)
    exceptions "Proceso bloqueado, en ejecución. [$DATE_TIME]" 1; exit 1;
    ;;
esac