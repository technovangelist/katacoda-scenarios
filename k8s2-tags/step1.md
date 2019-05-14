In the previous section we had a real application we were working with. We will come back to that soon, but for now let's just look at a simple collection of pods. They are all the same apart from their tags. Let's take a look at how useful those tags are.

1. Make sure all 50 pods in your environment are running or at least being created:
   `kubectl get pods --no-headers | awk {'print $3'}| datamash -s -g 1 count 1`{{execute}}
   *The GNU Utils datamash adds up the pods with each possible status and shows a count. Use just `kubectl get pods`{{execute}} to see the list of pods.*

2. Log in to <a href="https://app.datadoghq.com" target="_datadog">Datadog</a> and go to Infrastructure > <a href="https://app.datadoghq.com/infrastructure/map" target="_datadog">Host Map</a>

3. Now change the dropdown at the top left from **Hosts** to **Containers**.

4. In the **Group By** dropdown, get rid of **availability-zone** and choose **role**.
  
  *Notice that the containers are grouped by lb, web, db, backend, and no role. It's ok if all the containers aren't available yet. All 50 should eventually be available.* 

1. Now add **environment** to **Group By**. 

  *Look at the other choices in that drop-down to see the other tags that have been assigned to the pods. You can continue to slice and dice by any of them to look for any patterns that might exist.* 

1. In the editor to the right, choose the **lotsofpods.yaml** file. Notice that we have a collection of pods that are all mostly identical. The differences are in the tags.

1. The easiest way to define tags for Datadog on Kubernetes is to use annotations:

  <pre><code>annotations:
     ad.datadoghq.com/tags: '{"key": "value"}'</code></pre>

1. Scroll through the pods to see the various tags that have been assigned. Hopefully they look familiar after looking at the dropdown above. There were also other tags available in that dropdown. Where do you think they came from?

2. We want to try adding some other tags, but if we add them to lotsofpods its going to take a while to restart them. Instead open the couplemore.yaml file. This is just a couple more pods. Try adding some other tags. Then apply the changes and watch the tags appear in the dashboard:
   `kubectl apply -f k8s-yaml-files/couplemore.yaml`{{execute}}

   *It may take a few minutes to see them show up in the dashboard*
   
Continue on to the next page to start working with the tags in interesting ways.