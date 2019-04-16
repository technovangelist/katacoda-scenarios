1. Now that the tags are assigned, create a new timeboard. Add template variables for each of the four tag keys you saw in the lotsofpods.yaml file.
  1. To add a template variable, click the **Add Template Variables** link. 
  1. Click the **Add Variable +** button
  1. Choose **role** from the Tag Group dropdown. 
  1. Change the Name to **Role**. 
  1. Repeat with the other three tags.
1. Add a few timeseries graphs for some of the kubernetes metrics. For each, add the template variables to the **from** dropdown. 
  Some good metrics to add include:
    * kubernetes.pods.running
    * kubernetes.memory.rss
1. Play around with the various template variables to see how the dashboards updates based on your selections.
1. Switch to the **Hostmap** under the **Infrastructure** menu and change the view from **Hosts** to **Containers**. Now try changing the **Group By** and **Filter By** textboxes to the various tags. 
2. Try switching to the **Containers** and **Processes** view and change the tags to try out those views too.

