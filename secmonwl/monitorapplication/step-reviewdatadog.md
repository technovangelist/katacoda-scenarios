There are lots of pages in Datadog we can use to start to learn about our application. The Containers view is a wonderful source of information about all the containers in your environment, regardless of where they are running. They could be running in Docker, Kubernetes, EKS, EKC, and anywhere else. 

1.  Navigate to https://app.datadoghq.com/containers?sort=container_name%2CASC. This shows us all the containers running in our cluster. Scroll through the list and see if you recognize some of the container names. 
2.  There are probably a lot of containers listed. Try clicking the button labelled **Customize** just below the graph and above the list of containers. Enable the Host column. Now you can see where the containers are running and sort by container.
3.  Click on one of the containers on Node01 and try out the different options. Notice that we can see the commands being run in the container. Click on the command and you will switch over to the process view for that process. 
4.  Switch over to https://app.datadoghq.com/process. Here we see a similar view from the perspective of the actual processes that run across all of our containers. 
5.  Take a look at https://app.datadoghq.com/network/map. Its probably not very interesting right now. That's because we are looking at how the different hosts are talking to each other. At the top there is a drop-down labelled view. Change this to **pod_name**. This just became a lot more interesting. If it still isn't interesting, then go back to the StoreDog app and navigate around the site a bit more. Give it a few seconds to update then come back here. This is one area of the app that can take a lot of data to start populating the UI. 
6.  Since this is a web application and we have set up Real User Monitoring, navigate to RUM Applications under UX Monitoring. You should see the StoreDog application listed with some highlevel metrics shown. Click the **Application Overview** button.
7.  Here we can see a lot of information about how the application is rendering to our users. You can see the most viewed pages, where the users are, and if you tried using different browsers, you would see them here too. Also review the Sessions view as well as the different Dashboards.
