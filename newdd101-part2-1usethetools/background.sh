while [ ! -f /root/.kcrc ]; do sleep 1; done

source /root/.kcrc
wall -n $(env)

wall -n 7
