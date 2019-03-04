* Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>.  
* Navigate to the Dashboards List then Integrations.

## Install the HAProxy dashboard
* Hover over the HAProxy tile and click the Install button.
* Click Install Integration on the Configuration tab.
* Close the HAProxy modal window.
* Repeat the last three steps for Apache.

## Working with a dashboard
* Return to the Dashboards List.
  *You should see two new dashboards: Apache - Overview and HAProxy - Overview.*
* Click on the link for the Apache dashboard. 
  *Notice that there are three servers but the rate of requests is probably minimal.*
* From the terminal, SSH into the util virtual machine by running vagrant ssh util. Then run the command light. 
  *This will start hitting the HAProxy server and thus each of the Apache web servers.*
* Return to the Apache dashboard.
  *You should see an increase in the rate of requests.*
* Return to the Dashboards page and click on the other dashboard links.
  *See what has been created with each integration installed.*
