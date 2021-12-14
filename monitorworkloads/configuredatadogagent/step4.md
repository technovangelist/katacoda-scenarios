Let's take one more step and enable Real User Monitoring for our application. 

1.  Navigate to UX Monitoring (https://app.datadoghq.com/rum/list) and create a **New Application**. 
2.  Choose JS and enter Storedog for the name of the application. If you don't use the name **Storedog** then you will need to repeat this process at the beginning of the second lab.
3.  Click the **Create New RUM Application** button.
4.  Take note of your Application ID and Client Token in the instructions. 
5.  Enter the values into the corresponding values in the environment variables section of frontend.yaml.  ![RUM values in yaml](configuredatadogagent/assets/rumvalues.png)
6.  Apply the changes by running this command: `k apply -f deploy/generic-k8s/ecommerce-app/frontend.yaml`{{execute}}. As on the previous page, you should see the deployment is configured and the service is unchanged.
7.  Open the Storedog application by clicking the Storedog tab above the editor. Try out the different pages of the app. We need to generate some user activity to monitor so the more you do here, the more you will be able to review in the next few steps.
8.  Back in Datadog, you should now see **Data is reporting successfully**, and you can click on the button: **Explore User Sessions**.
9.  If you are having trouble seeing any information shoing up in the User Sessions UI, try promoting Storedog to a new tab by clicking the icon in the tab that looks like a box with an arrow pointing to the top right. Or if you have any ad blockers like PiHole enabled, try disabling it or whitelist the relevant Datadog endpoints.
10. You should see at least one session. Click on it to see everything you did when you worked with the website a couple steps ago. Click on any of the pages to see the full waterfall chart. This shows the load time for each of the assets requested by the browser. 