1.  Open https://app.datadoghq.com and login using the credentials provided in the terminal. 
2.  Under Infrastructure take a look at the Host Map. Each hexagon represents a single host or instance in our environment. 
3.  Click on the hexagon that represents our single host. If you have gone through any other classes recently you may still see some other hosts being displayed.
4.  Now change the drop-down at the top left from Hosts to Containers. 
5.  Notice that you now have a few more hexagons displayed, one for each container in our environment. 
6.  From the infrastructure menu, click **Processes**. We can now see the processes running in each of our instances.
7.  Click on any of the processes that you recognize and look around.
8.  Take a look at Network under Infrastructure. Here you can see the amount of network traffic traveling between our nodes.
9.  Finally take a look at the Network Map under Infrastructure. Now you can visualize those connections. Hover over each of the instances to see more detail.
10. Navigate to the **Service Map** under **APM**. If you don't see anything here, you may need to wait a few minutes for data to start to appear here. You should see each of the services of the application and how they are linked to each other. If you see **No services reported for env:none**, then change the environment dropdown from **env:none** to **env:development**.
11. Click on **Store Frontend** and choose to **View the Service Overview**. Scroll down the page and notice the different types of information available. 
12. Click on the **Spree::HomeController** endpoint. Click on one of the spans at the bottom of the page. You should see a flamegraph representing that particular request. 
13. Try the other options from the **Service Map**. Take a look at the other services on the map.
