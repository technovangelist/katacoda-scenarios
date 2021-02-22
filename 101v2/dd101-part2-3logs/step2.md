1. Open the <a href="https://app.datadoghq.com/logs" target="_datadog">Log Explorer</a> in Datadog.

    _You should be seeing logs coming in now. The screen will refresh on it's own, but you can always press the refresh button as well towards the top right of the screen_

2. We haven't done much to get useful information out of the logs, but already some pipelines have been automatically created. Expand the **Source** and **Service** facets on the left side.

     _Notice that you can filter the logs based on any of the facets that have been identified._

3. Open some of the other facets to see what else has been identified.

4. Click on one of the log lines.

    _Notice the information being extracted from the log line. You might have to look around to find one that is extracting attributes because we haven't done any configuration. Use the up and down arrow keys to display other log lines. The `agent` service entries should have attributes._

5. Now navigate to <a href="https://app.datadoghq.com/logs/pipelines" target="_datadog">Logs Configuration</a>, where we'll take a look at pipelines.

6. Depending on how long you have taken in this section, you may see a few active pipelines. Click on the **Datadog Agent** pipeline.

    _Notice that the filter is set to **source:agent**. Anything that comes from the agent will be processed by this pipeline._

7. Double-click on the first item in the list: **Grok Parser: Parsing Datadog Agent logs**.

    _Here you can see the rules used by Datadog to parse the Agent log lines. To get a better understanding of what some of this means, click the small question mark next to **Define parsing rules**._

8. Look through the rest of the pipelines. See if you can identify some of the pipelines that extracted the facets we saw earlier in the Logs Explorer.

9. One more thing to look at that is incredibly useful before and after you do any configuration is the <a href="https://app.datadoghq.com/logs/patterns" target="_datadog">Log Patterns</a> view.

    _Scroll through the patterns. You can very quickly identify problems and issues you should work on right away_

Spend some time playing around with the various options and settings in the Pipelines view. 

There is so much you can do with logs in Datadog and if you haven't worked with the feature, please check out our training on the Learning Platform. 

When you are done with this section, run `grademe`{{execute}} to indicate that you are done. Then click the **Continue** button.