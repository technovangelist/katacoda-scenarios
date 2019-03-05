1.  Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>.  
2.  Navigate to the Dashboards List then Integrations.

## Install the HAProxy dashboard
3.  Hover over the HAProxy tile and click the Install button.
* Click Install Integration on the Configuration tab.
* Close the HAProxy modal window.
* Repeat the last three steps for Apache.

## Working with a dashboard

* Return to the Dashboards List.<br>
  *You should see two new dashboards: Apache - Overview and HAProxy - Overview.*
* Click on the link for the Apache dashboard. <br>
  *Notice that there are three servers but the rate of requests is probably minimal.*
* From the first terminal tab, run the command `light`{{execute T1}}.<br>
  *This will start hitting the HAProxy server and thus each of the Apache web servers.*
* Return to the Apache dashboard.<br>
  *You should see an increase in the rate of requests.*
* Return to the Dashboards page and click on the other dashboard links.<br>
  *See what has been created with each integration installed.*

**When you are finished, quit the `light` command and then run `grademe`{{execute}} in the terminal. If you have earned the full score, click the **Continue** button to end the scenario.**
