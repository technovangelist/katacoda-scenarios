In this course, we are going to work with the StoreDog ecommerce app. This lab will just introduce you to the application and how it is being monitored. For this lab, the application is running in a docker-compose environment. We also have a GoReplay job running that is putting some load on the application. 
1.  At the top of the terminal you will see a username and password. This is the login you should use on Datadog, even if you have a login provided to you at work. If the login information scrolls out of view, you can always run `creds` to see the credentials.
2.  Click on the StoreDog tab on the right side. This will open the app in your browser. 
3.  Look around the page. Refresh your browser and notice that the coupon code at the top left updates. This is being served by the discounts server. 
4.  In the search box at the top right, enter `cup` to search for cups. Click on one of them. 
5.  Open `app.datadoghq.com` and login using the credentials provided at the top of the terminal. 
6.  Navigate to the Service Map under APM. If you don't see anything here, you may need to wait a few minutes for data to start to appear here. You should see each of the services of the application and how they are linked to each other.
7.  Click on Store Frontend and choose to View the Service Overview. Scroll down the page and notice the different types of information available. 
8.  Click on the Spree::HomeController endpoint. Click on one of the spans at the bottom of the page. You should see a flamegraph representing that particular request. 
9.  Try the other options from the Service Map. Take a look at the other services on the map. 
10. 