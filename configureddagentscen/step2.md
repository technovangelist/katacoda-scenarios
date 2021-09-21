
1. Open <a href="https://app.datadoghq.com" target="_datadog">app.datadoghq.com</a> and navigate to Integrations. Enable the Postgres integration, if it isn't already enabled. 
2. Now you should be able to visit Dashboards and open either of the Postgres dashboards and see their metrics show up.
3. What else can we see in the Datadog environment? Take a look at some of the other dashboards. Depending on whether they have been autodiscovered or not, you may see dashboards for different components of Kubernetes. If you don't, click on the Integrations menu and enable the integrations for CoreDNS, Docker, etcd, kube-controller-manager, Kubernetes, and kube-scheduler.   
4. From the Infrastructure menu, click on the hostmap.
5. This isn't very interesting yet, but we can change the map to show Containers at the top left, and then choose to group by kube_service or anything else that has been used as a tag. 
6. Switch over to the Container menu under Infrastructure. Here we can see all of the containers in our Kubernetes environment. Click on any one of them to see the command they are running, as well as some high level metrics.
7. Try the Network Map under the Infrastructure menu. Viewing by host is a bit uninteresting, so change the View menu to view by kube_service. Here we can see the network traffic between each of the components of our app.

On the next page we will configure the frontend to submit APM traces to Datadog.


