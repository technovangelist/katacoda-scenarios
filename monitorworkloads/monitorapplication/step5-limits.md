Now we have seen one way the scheduler makes monitoring a little different on Kubernetes vs other more traditional platforms. Let's look at another aspect of the scheduler. In Kubernetes there is the concept of resources which show up in the manifests as requests and limits. 

When you specify a request for memory or CPU, that is the minimum that the pod requires to run. If it requests more than is available, the scheduler won't schedule it. 

You can also specify a maximum amount of memory or CPU that the pod can take. You might have a pod that takes more memory if its available but that may result in another pod that needs a certain minimum not being allowed to run. Also, if the limit is higher than the allocatable memory on the node and the pod starts to try to consume that memory, it will be killed. This is called an eviction.

1.  In case you skipped that step, make sure the changes you made to the **hostPort** and **replicas** on the previous page are rolled back. Delete the **hostPort** line and change **replicas** back to 1. 
1.  Open the **frontend.yaml** manifest in the IDE. Undo the changes you made in the previous section. So you should make sure replicas is set to 1 and remove the hostPort setting. 
2.  At line 72 you should see the resource requests. Update the `cpu` setting to `1500m` and `memory` to `1500Mi`. 
3.  Apply the changes using the command `k apply -f deploy/generic-k8s/ecommerce-app/frontend.yaml`{{execute}}.
4.  Look around at the various dashboards to see if you can find a graph that shows the increased usage.
5.  Try updating `memory` to consume `5000Mi` which is far more than what is available. Review the dashboards to see if any show you the problem.
6.  How would you create a monitor that alerts you to the problem you are seeing?