

In our quick look at some of the Datadog features, monitoring your workloads on Kubernetes is almost identical to monitoring workloads hosted in a VM. But there is one main thing that is unique about Kubernetes that you should pay attention to. 

With older clustering technologies, there was a hard requirement that all nodes must be equal: equal memory, storage, CPU, IO, and everything else. But with Kubernetes there is no such requirement. So in a cluster with 10 nodes, all of them may have slightly different configurations. The way the scheduler works is that it looks at the processor and memory requirements of the deployment, and finds a node that is capable of accommodating those requirements. 

  As a result, paying attention to the key metrics of the Scheduler is very important. 

1.  From the Dashboards menu, open the **Kubernetes Scheduler - Overview** dashboard. 
1.  Scheduled Attempts at the top of the dashboard is a great one to watch. Let's update our frontend deployment to be partially unschedulable. In the editor, open **deploy/generic-k8s/ecommerce-app/frontend.yaml**.
2.  Line 69 defines the ports that the frontend should respond to. Update that block to:
    
        ports:
        - containerPort: 3000
          protocol: TCP
          hostPort: 12345
3.  Rather than just using a port on the container that is abstracted, you are telling the pod that it always needs to use port 12345 on the host.
4.  Apply frontend.yaml using the command `k apply -f deploy/generic-k8s/ecommerce-app/frontend.yaml`{{execute}} and you will see that everything works as expected. This is because there is only one copy of the pod being scheduled. 
5.  On **line 12** of **frontend.yaml** is where the number of replicas is defined. Change the number 1 to a 3. Apply the yaml file. 
6.  Open the **Kubernetes Scheduler - Overview** dashboard and watch what happens. 
7.  We have one available node and thus one target available for the scheduler to schedule a pod that needs port 12345 on the host. That one pod will be scheduled and the second and third will be unschedulable. If it looks like nothing is different, notice the legend for the graph and that when you hover over the new bar, it shows **unschedulable**.
8.  You probably don't want to just watch the dashboard for problems, so let's setup a monitor to notify us of a problem. You can create a monitor from <a href="https://app.datadoghq.com/monitors#/create" target="_datadog">the New Monitors page</a>. Create a new Metric Threshold Monitor. 
9.  Set the Metric to `kubernetes_state.deployment.replicas_desired`, and `sum by` `kube_deployment`. We can see the total number of replicas desired for each new or updated deployment on our cluster since the Agent started. But this doesn't let us know if there is a problem yet.
10. Click the **Advanced** link and then the **Add Query** button.
11. Set the second Metric to be `kubernetes_state.deployment.replicas_available` and `sum by` `kube_deployment`.
12. In the text box next to **Express these queries as:** enter `a - b`. Now the graph above looks pretty interesting. 
13. Let's set the **Alert Conditions**. Set **Alert threshold** to 2, **Warning threshold** to 1, and the recovery thresholds to 1 and 0. 
14. Then set it to trigger when the metric is above the threshold on average for the last **5 minutes**.
15. Add a message to the **What's Happening** section. You might want the subject to be `Replicas for {{kube_deployment.name}} not being scheduled` and the message to be `Replicas for {{kube_deployment.name}} are being requested but not scheduled. {{value}} replicas could not be scheduled.`.
16. Click on the Save button at the bottom, then click on **Manage Monitors** to see the list of all configured monitors.
17. Now you have to wait a little bit. First you have to wait for data to populate, then you need to wait another minute because the monitor will only trigger after the threshold has been hit for 1 minute. 
18. Soon you should see our new monitor change to a red Alert. Click on the Monitor. You should now see the status of the frontend pod vs the other pods. 
19. Update the number of **replicas** back to 1 and remove the line for the **hostPort**. Then apply it with kubectl. 

Perhaps this is a contrived example, but it is quite possible to have a deployment that requires a certain amount of memory and multiple replicas and that amount is only available on a few nodes. 

The **Kubernetes - Overview** is another important dashboard to review. It will give you a good complete picture of your cluster and identify the most cpu- and memory-intensive pods. As with most of the integration dashboards like these be sure to look into the template variables as well. You can choose to filter down by deployment and choose the frontend deployment. Now you can see all of the key metrics that affect just that one deployment. Try out some of the other options to see what is available.
