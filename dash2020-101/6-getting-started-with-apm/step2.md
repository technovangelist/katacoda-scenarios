1.  Open Datadog in a new browser tab or window. Navigate to APM.
2.  You will see all the services for our application are listed here. Click on each one to see the information collected so far.
3.  Notice at the top of the window there is a block that says **No Monitors or Synthetic Tests**. Click it. 
4.  It offers to enable some monitors automatically. Click **Enable** for the **p90 latency** monitors for each service so that we can easily see things are taking too long. It may take a few minutes to get enough data to trigger the alert.
5.  From the **APM** menu, choose to open the **Service Map**. Here we can see how the different services relate to each other.
6.  Hover over **store-frontend** to see how it shows which services it works with directly. 
7.  Click on **store-frontend** and then choose to view **Service Overview**. 
8.  There is a lot in this view and we could spend hours here. Scroll down to see the **Endpoints** and click on the **Errors** heading to sort by errors.
9.  One of the Endpoints experiencing errors is `Spree::OrdersController#edit`. Click it to open. 
10. Scroll all the way down to see the traces. Click on the most recent one. 
11. Here we can see a flamegraph of this request. Errors cascade up, so look for the lowest span with an error. You can see the problem is with a template. Click on the span and you can see the actual error and the developer should have enough to go work on a solution. 

There is much more that you can do with APM than what we can show you in 15 minutes and if you are interested in learning more, vist learn.datadoghq.com to take our course on the topic. 