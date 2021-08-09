1.  Navigate to Real User Monitoring at this URL: https://app.datadoghq.com/rum. Or navigate to **UX Monitoring -> Real User Monitoring**
2.  Click the button to create a **New Application**.
3.  For **Application type**, choose JS.
4.  Enter **frontend** for the **Application Name**.
5.  Click the **Create New RUM Application** buttton. 
6.  Take note of the **applicationId** and **clientToken** strings.
7.  Stop the app from the terminal by running `docker-compose -f deploy/docker-compose/docker-compose-traffic-replay.yml stop`{{execute}} and  `docker-compose -f deploy/docker-compose/docker-compose-fixed-instrumented.yml down --remove-orphans`{{execute}}
8.  Open the IDE tab and then open **deploy/docker-compose/docker-compose-fixed-instrumented.yml** Update lines 53 and 54 with the client token and application ID you collected from the app in an earlier step.
9.  Now run `docker-compose -f deploy/docker-compose/docker-compose-fixed-instrumented.yml up -d`{{execute}} to start, then `docker-compose -f deploy/docker-compose/docker-compose-traffic-replay.yml up -d`{{execute}}
10. Visit the application website and do a search and add something to the shopping cart. 
11. Switch back to the RUM UI. Within a few seconds you should see the page verify the installation. 
12. Now you should be able to move on to see the session you just started. 

Real User Monitoring is great to see how your users are actually experiencing the website. Try visiting the application site and navigating around to a few different pages. Run a search. Then update the session in RUM to see the updated flow. 