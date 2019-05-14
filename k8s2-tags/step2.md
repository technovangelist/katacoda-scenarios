1. Now that the tags are assigned, create a new timeboard. 
  *If you aren't sure how to do this, consider taking the **Introduction to Datadog** course to get up to speed with the basics. Essentially, go to Dashboards, and choose to create a Timeboard.*
2. Add template variables for each of the four tag keys you saw in the lotsofpods.yaml file.
  1. To add a template variable, click the **Add Template Variables** link. 
  2. Click the **Add Variable +** button
  3. Choose **role** from the Tag Group dropdown. 
  4. Change the Name to **Role**. 
  5. Repeat with the other three tags.
3. Add a few timeseries graphs for some of the kubernetes metrics. For each, add the template variables to the **from** dropdown. 
  Some good metrics to add include:
    * kubernetes.pods.running
    * kubernetes.memory.rss
4. Play around with the various template variables to see how the dashboards up
5. We have already worked with the container map so try switching to the **Containers** view and work with the tags.
6. Now try the **Processes** view and change the tags to try out those views too.

