while [ ! -f /root/.bashrc ]; do sleep 1; done

wall -n $(cat /root/.bashrc)
source /root/.bashrc
wall -n $(env)

wall -n 6
