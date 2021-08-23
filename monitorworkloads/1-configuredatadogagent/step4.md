Let's take one more step and enable Real User Monitoring for our application. 

1.  Navigate to UX Monitoring and create a New Application. 
2.  Choose JS and enter Storedog for the name of the application
3.  Click the **Create New RUM Application** button.
4.  Take note of your Application ID and Client Token in the instructions. 
5.  Enter the values into the corresponding values in the environment variables section of frontend.yaml. 
6.  Apply the changes by running this command: `k apply -f deploy/generic-k8s/ecommerce-app/frontend.yaml`{{execute}}.
7.  Back in Datadog, you should now see **Data is reporting successfully**, and you can click on the button: **Explore User Sessions**.
8.  