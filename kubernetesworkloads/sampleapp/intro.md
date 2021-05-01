xxyy

watch -g -n 3 'curl  -s -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36" https://katacoda.com/technovangelist@dd/courses/kubernetesworkloads/sampleapp | htmlq head meta[name=lastUpdated] -a content'


curl  -s -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36" https://katacoda.com/technovangelist@dd/courses/kubernetesworkloads/sampleapp | htmlq head meta[name=lastUpdated] 