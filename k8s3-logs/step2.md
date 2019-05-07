1. Open the <a href="https://app.datadoghq.com/logs" target="_datadog">Log Explorer</a> in Datadog.
   *You should be seeing logs coming in now. The screen will refresh on it's own, but you can always press the refresh button as well towards the top right of the screen*

2. We haven't done much to get useful information out of the logs, but already some pipelines have been automatically created. Expand the **Source** and **Service** facets on the left side.
   *Notice that you can filter the logs based on any of the facets that have been identified.*
3. Open some of the other facets to see what else has been identified.
4. Click on one of the log lines. 
   *Notice the information being extracted from the log line. You might have to look around to find one that is extracting any attributes since we haven't done any configuration. Use the up and down arrow keys to display other log lines.*
5. Now navigate to <a href="https://app.datadoghq.com/logs/pipelines" target="_datadog">Logs Configuration</a>.
6. Depending on how long you have been in this course, you may see up to 4 active pipelines. Click on the **Datadog Agent** pipeline.
   *Notice that the filter is set to **source:agent**. Anything that comes from the agent will be processed by this pipeline.*
7. Double-click on the first item in the list: **Grok Parser: Parsing Datadog Agent logs**.
   *Here you can see the rules used by Datadog to parse the Agent log lines. To get a better understanding of what some of this means, click the small question mark next to **Define 1 or multiple parsing rules**.*
8. Look through the rest of the pipelines. See if you can identify some of the pipelines that extracted the facets we saw earlier in the Logs Explorer. 

9.  One more thing to look at that is incredibly useful before and after you do any configuration is the <a href="https://app.datadoghq.com/logs/patterns" target="_datadog">Log Patterns</a> view.
    *Scroll through the patterns. You can very quickly identify problems and issues you should work on right away*

There is so much you can do with logs in Datadog and if you haven't worked with the feature, please check out our training here on the Learning Platform. Let's move on to setting up Application Performance Monitoring.