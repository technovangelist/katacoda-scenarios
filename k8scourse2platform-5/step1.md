Ideally, all components of the control plane are autodiscovered. That didn't work out for etcd, but that allowed us to see how to setup an integration using Helm. The API Server has been autodiscovered correctly so there is almost nothing we need to do to start working with it. 

1.  Start by verifying that all our pods are up and running: `k get pods -w`{{execute}}. The `-w` command line option means **watch**. Unlike tools like `top`, `k get pods -w` doesn't update each line as information changes, but rather it acts like tailing a log. As the status changes, another line is added. By the time everything is running it might look like you have a dozen datadog-related pods, but you only have two. 
1.  When the main datadogagent pod is fully ready, get the agent status: `k exec $(k match-name datadogagent-[a-z0-9]{5}) agent status`{{execute}}. 
1.  Scroll up to see what checks are running. You can also take a look at the configcheck command: `k exec $(k match-name datadogagent-[a-z0-9]{5}) agent configcheck`{{execute}}

api server

- video is about this:
- Understanding the metrics to watch
- Request rates and latency
- Controller worker queues
- Etcd objects
- System metrics
- cpu, mem, file descriptors, 
- Reviewing audit logs (did the blog post ever happen)

api server is a specialized webserver, watch request rates and latencies, more general proces stats, file descriptors, memory, cpu

look at the etcd and controller metrics that are part of api server

show how to log to datadog, then loook at controle plane components, authentication issues, client cert, slow requests
a
