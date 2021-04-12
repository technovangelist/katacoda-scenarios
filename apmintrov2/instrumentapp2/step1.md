In the terminal on the right, the Storedog app is being deployed using Docker. Live traffic to the app is also being simulated. This may take up to 2 minutes. Once the app is running, you will see the message `Provisioning Complete` in the terminal along with your Datadog login credentials.

1. Click `docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml`{{open}} to view the file in the editor on the right. <p> This docker-compose file instruments the Datadog agent and app services for monitoring with Datadog. <p> Browse the file to view the details of the deployment. As you can see, there are no specifications for apm or log collection. 

2. Once you see the `Provisioning Complete` message, click the **storedog** tab above the terminal to view the Storedog app. <p> Clicking around inside the app, you can see it includes a home page, product pages, advertisements, discounts, and a shopping cart. <p> 

In this activity, you will go through instrumentation of the  store-frontend (home page), discounts, and advertisements services for APM in Datadog. But first, let's enable trace and log collection for the Datadog Agent.