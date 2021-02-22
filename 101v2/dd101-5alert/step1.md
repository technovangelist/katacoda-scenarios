1.  From the first terminal, launch the `light`{{execute T1}} script. This will send a light stream of events the Datadog API that we can monitor.
2.  Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a> and navigate to the **New Monitor** page.
3.  Choose **Metric** to create a new Metric monitor.
4.  Choose **Change Alert** under **Choose the detection method**.
5.  Under **Define the metric**, select `apache.net.hits`.
6.  Set a Multi Alert by server by selecting **avg by** and then select **host** in the **(everything)** field.<br>
    _Do you think its more valuable to have a monitor for each web server, or for the combination of all of them?_
7.  Set the **Set alert conditions** group of choices to: The `average` of the `change` over `5 minutes` compared to `1 minute` before is `above` the threshold for any host.<br>
    _This section lets you configure when you want this monitor to fire._
8.  Then set the alert threshold to `500` and the warning threshold to `250`. <br>
    _This says if the average over 5 minutes is 500 more than the average over 1 minutes a minute ago, then fire the monitor._
9.  In the **"Say what's happening"** section of the screen, populate these fields as shown:<br>

Example Monitor Name: Lots of Apache Hits Happening<br>
Example Monitor Message: Host {{host.name}} with IP {{host.ip}} is under heavy load.

_Note: For more examples of what you can put in the ExampleMonitor Message dialog, click the **Use message template variables** link to learn about conditional statements, variables, and more._

1.  Since this is just going to be informational and not a notification, leave the **Notify your team** section blank.
1.  Scroll to the bottom of the page and click **Save**.
1.  From the first terminal tab, type CTRL-C to stop the `light` script, and run the `heavy`{{execute T1}} script.
1.  Navigate to the Manage Monitors page to see the status for the alert change. It will take at least 5 minutes for the new monitor's alert to be triggered.
1.  Navigate to the Triggered Monitors page to see a triggered monitor for each of the three webservers.
1.  Click on the name of one of the triggered monitors. <br>
    _This page shows you the current status of the monitor and its history._
