In this section we are going to install the Datadog agent to our cluster. There are two main ways to install the agent, either using a series of Kubernetes YAML files, or as a Helm chart. Using helm is the easier away and the approach we will take. When using helm, there is nothing you need to download to manually install the agent beyond simply installing helm. Instead, you configure the helm chart by customizing a values yaml file. 

1.  In the IDE, open **section3/values.yaml**. Take a moment to scroll through this file. It is well documented and most items in the file should be fairly easy to understand. 
2.  Run the following command to install the Datadog agent: `helm install datadogagent datadog/datadog --set datadog.apiKey=$DD_API_KEY -f ./values.yaml`.
3.  Run `k get pods -w` to watch the pods as they start up. When the agent shows that it's running, run `k exec <name of agent pod>  agent status`.





In the Introduction to Monitoring the Kubernetes Platform course we show you how to configure and monitor the Kubernetes platform. In this scenario we are going to do a quick review of how our monitoring is configured then a quick reminder of the monitoring features in Datadog. 

1.  As we did in the Platform course, we installed the Datadog Agent using the Helm chart. Open the IDE and navigate to `deploy/datadog/helm-values.yaml`. This is almost the same as the default values file you can find at https://github.com/DataDog/helm-charts/blob/master/charts/datadog/values.yaml. Here is a list of the items that we have changed, mostly for compatibility with our lab platform.
    1.  Line 19 - changed the registry from the default of gcr to dockerhub. Our labs vendor will automatically cache images hosted on dockerhub.
    2.  Line 59 - clusterName is set to k8sworkloads
    3.  Line 133 - tlsVerify is set to false due to the limitations of our lab platform
    4.  Line 255 - Updated configuration of the etcd.yaml file for the lab platform
2. Now open Datadog and login using the credentials provided in the lab terminal. If the credentials are no longer on screen, run the command `creds` to redisplay them.
3. First lets consider some of the metrics to watch for etcd (If you aren't sure what etcd is used for, you really should look at the course on monitoring the kubernetes platform). Start by looking at the integration dashboard for etcd. 
4. In the platform course, we looked at proposals, both commited and applied, subtracting commited from applied, because hopefully all the proposals applied have been commited. 
5. Then we looked at disk performance. etcd.disk.wal.fsync.duration.seconds and etcd.disk.backend.commit.duration.seconds are both good metrics to watch. You can either add these to a new dashboard, or use the Metric Explorer to try these out. 
6. We then used a forecast formula on etcd.debugging.mvcc.db.total.size.in_bytes tto keep an eye on where the db size is heading. 