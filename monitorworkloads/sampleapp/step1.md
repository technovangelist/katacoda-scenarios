In this course, we are going to work with the StoreDog ecommerce app. This lab will just introduce you to the application and how it is being monitored. For this lab, the application is running in a docker-compose environment. We also have a GoReplay job running that is putting some load on the application. 

1.  At the top of the terminal you will see a username and password. This is the login you should use on Datadog, even if you have a login provided to you at work. If the login information scrolls out of view, you can always run `creds` to see the credentials.
2.  Click on the StoreDog tab on the right side. This will open the app in your browser. 
3.  Look around the page. Refresh your browser and notice that the coupon code at the top left updates. This is being served by the discounts server. 
4.  In the search box at the top right, enter `cup` to search for cups. Click on one of them. 
5.  Add the item to the shopping cart.
6.  Change the number of items in the cart and update it.
7.  Take a look around at some of the other features of the application. 
