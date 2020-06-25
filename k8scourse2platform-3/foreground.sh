while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
# while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 5 ]; do
#   sleep 0.3
# done
# while [ ! 'k get nodes 2>/dev/null | wc -l ' eq 2]; do
#   sleep 0.3
# done
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl completion bash >/etc/bash_completion.d/kubectl
complete -F __start_kubectl k
clear
prepenvironment