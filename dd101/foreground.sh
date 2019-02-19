#!/bin/bash -ex
{ set +x; } 2>/dev/null
echo "shell tracing is disabled here"; set -x;
echo "but is enabled here"

alias echo='{ set +x; } 2> /dev/null; builtin echo'
echo "Building out the Learning Environment."
  
spin.sh
