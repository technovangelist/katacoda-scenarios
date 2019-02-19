#!/bin/sh -x
alias echo='{ set +x; } 2> /dev/null; builtin echo'
echo "Building out the Learning Environment."
  
spin.sh
