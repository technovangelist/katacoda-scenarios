while [ ! -f /root/.kcrc ]; do sleep 1; done

source /root/.kcrc
wall -n $DD_API_KEY

wall -n 8
