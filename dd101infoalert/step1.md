1.  From the first terminal, launch the `light`{{execute T1}} script.
1.  Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a> and navigate to the **New Monitor** page.
1.  Choose **Metric** to create a new Metric monitor.
1.  Choose **Change Alert** under **Choose the detection method**.
1.  The metric we want to watch is `apache.net.hits`.
1.  Set a Multi Alert by server by selecting **avg by** and then select **host** in the **(everything)** textbox.<br>
  *Do you think its more valuable to have a monitor for each web server, or for the combination of all of them?*
1.  Set the **Set alert conditions** group of choices to: The `average` of the `change` over `5 minutes` compared to `1 minute` before is `above` the threshold for any host.<br>
  *This section lets you configure when you want this monitor to fire.*
1.  Then set the alert threshold to `500` and the warning threshold to `250`. <br>
  *This says if the average over 5 minutes is 500 more than the average over 5 minutes a minute ago, then fire the monitor.*
1.  In the **"Say what's happening"** section of the screen, populate these fields as shown:<br>

  Example Monitor Name:  Lots of Apache Hits Happening<br>
  Example Monitor Message:  Host {{host.name}} with IP {{host.ip}} is under heavy load.

  *Note:  For more examples of what you can put in the ExampleMonitor Message dialog, click the **Use message template variables** link to learn about conditional statements, variables, and more.*
1.  Since this is just going to be informational and not a notification, leave the **Notify your team** section blank.
1.  Scroll to the bottom of the page and click **Save**.
1.  From the first terminal tab, run the `heavy`{{execute T1}} script.
1.  Navigate to the Manage Monitors page to see the status for the alert change.
1.  Navigate to the Triggered Monitors page to see a triggered monitor for each of the three webservers.
1.  Click on the name of one of the triggered monitors. <br>
  *This page shows you the current status of the monitor and it's history.*

**When you are finished, run `grademe`{{execute}} in the terminal. If you have earned the full score, click the **Continue** button to end the scenario.**
