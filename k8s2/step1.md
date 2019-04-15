In the previous section we had a real application we were working with. We will come back to that soon, but for now let's just looking at a simple collection of pods. They are all the same apart from their tags. Let's take a look at how useful those tags are.

1. Log in to Datadog and go to Infrastructure > Host Map
1. Now change the dropdown at the top left from **Hosts** to **Containers**.
1. In the **Group By** dropdown, get rid of **availability-zone** and choose **role**.
  
  Notice that the containers are grouped by lb, web, db, backend, and no role. 
1. Now add **environment** to **Group By**. 

  Look at the other choices in that drop-down to see the other tags that have been assigned to the pods. You can continue to slice and dice by any of them to look for any patterns that might exist. 
1. In the editor to the right, choose the **lotsofpods.yaml** file. Notice that we have a collection of pods that are all mostly identical. The differences are in the tags.
1. The easiest way to define tags for Datadog on Kubernetes is to use annotations:
  `annotations:
    ad.datadoghq.com/tags: '{"key": "value"}'`
1. Scroll through the pods to see the various tags that have been assigned. Hopefully they look familiar after looking at the dropdown above. There were also other tags available in that dropdown. Where do you think they came from?

Continue on to the next section to start working with the tags in interesting ways.