In this course, we are going to work with the StoreDog ecommerce app. This lab will just introduce you to the application and how it is being monitored. For this lab, the application is running in a docker-compose environment. We also have a GoReplay job running that is putting some load on the application. 

1.  At the top of the terminal you will see a username and password. This is the login you should use on Datadog, even if you have a login provided to you at work. If the login information scrolls out of view, you can always run `creds` to see the credentials.
2.  Click on the StoreDog tab on the right side. This will open the app in your browser. 
3.  Look around the page. Refresh your browser and notice that the coupon code at the top left updates. This is being served by the discounts server. 
4.  In the search box at the top right, enter `cup` to search for cups. Click on one of them. 
5.  Add the item to the shopping cart.
6.  Change the number of items in the cart and update it.
7.  Take a look around at some of the other features of the application. 
6.  Open `app.datadoghq.com` and login using the credentials provided at the top of the terminal. 
7.  Under Infrastructure take a look at the Host Map. Each hexagon represents a single host or instance in our environment. 
3.  Click on the hexagon that represents the database (db).
4.  Try clicking on the pill for postgres. Now we can see metrics for postgres on this instance.
5.  From the infrastructure menu, click **Processes**. We can now see the processes running in each of our instances.
6.  Click on any of the processes that you recognize and look around.
7.  Take a look at Network under Infrastructure. Here you can see the amount of network traffic traveling between our nodes.
8.  Finally take a look at the Network Map under Infrastructure. Now you can visualize those connections. Hover over each of the instances to see more detail.
9.  Navigate to the **Service Map** under **APM**. If you don't see anything here, you may need to wait a few minutes for data to start to appear here. You should see each of the services of the application and how they are linked to each other.
10. Click on **Store Frontend** and choose to **View the Service Overview**. Scroll down the page and notice the different types of information available. 
11. Click on the **Spree::HomeController** endpoint. Click on one of the spans at the bottom of the page. You should see a flamegraph representing that particular request. 
12. Try the other options from the **Service Map**. Take a look at the other services on the map.
