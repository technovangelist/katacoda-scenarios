Let's analyze how the changes you made affected app performance.

1. Navigate to <a href="https://app.datadoghq.com/apm/app-analytics/analytics" target="_datadog">**APM** > **App Analytics**</a>. Make sure that the Graph icon is selected on the left of the search field.

2. In the graph metrics editor below the search field, select `Resource` for **group by**.

3. In the **Facets** on the left, select `Error` under **Status**. `ERROR` appears in the search field as a filter. <p> Notice that the resources/endpoints that had the `ActionView::Template::Error: undefined method [] for nil:NilClass` error are the only resources in the graph. <p> Also, notice that there are no more errors since you restarted the app.

4. Delete `ERROR` from the search field. 

5. In the graph metrics editor, change `*` to `Duration`. (**Count** will automatically change to **Measure**.) <p> Notice the drop in durations for certain resources after you restarted the app. <p> Hover over each name in the legend below the graph to see which resources had improved performance after fixing the discounts and advertisements services.

6. Navigate to <a href="https://app.datadoghq.com/apm/map" target="_datadog">**APM** > **Service Map**</a>. <p> The outline of the store-frontend, discounts-service, and advertisements-service nodes are now green, meaning the monitor for each service is in the `OK` status.

7. Click the store-frontend service node and select **View service overview**. <p> Notice that the **Total Requests** and **Total Errors** graphs have no new error data since you fixed the store-frontend.

Let's explore the store-frontend service more to see if the app has any other undesired behavior.