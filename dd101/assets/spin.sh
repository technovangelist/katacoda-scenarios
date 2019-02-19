#!/bin/bash

show_progress()
{
  echo -n "Building out the Learning Environment."
  local -r pid="${1}"
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp

  while true; do 
    grep -i "done" status.txt &> /dev/null
    if [[ "$?" -ne 0 ]]; then     
      status=`cat status.txt`
      printf "${status}"
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\r                                           \r"

    else
      break
    fi
  done

}

show_progress