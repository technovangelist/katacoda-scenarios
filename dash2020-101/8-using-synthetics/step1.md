This lab requires using Chrome. A Chrome extension is used so Chrome is required. If you cannot use Chrome, read through the steps and then you will be able to try the API Test later in this section.  


1.  Open the Datadog app and navigate to **Synthetics** from the **UX Monitoring** menu.
2.  Click the **Get Started** button on the **Get Started with Datadog Synthetics** page.
3.  Click **Browser Test**.
4.  For **Starting URL** you should enter this URL: https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/
5.  Expand **Advanced Options**. Here you can add another **Request Header**, **Cookies**, and **Basic Auth** to your request.
6.  Enter a name for the test.
7.  Then you can choose what kind of device should do the test. Let's leave it at **Laptop Large**.
8.  Next choose some locations for our test. Choose two or three locations. The lab environment isn't a very performant machine so please be kind. 
9.  Set the Test Frequency to 30 minutes.
10. Click on **Save Details and Record Test**.
11. Since you probably don't have the Chrome Extension, install it. 
12. Click the **Start Recording** button.
13. Perform a search for bag, then choose Datadog Bag. Add the bag to the cart. 
14. Click to add a new **Assertion** and choose to test an element's content. 
15. You may have to open the site in a popup. Then select the total. For value, enter the value of the total cost. We are going to make sure when adding an item to the cart, its always a certain value. 
16. Click **Stop Recording**. Then **Save and Launch Test**.
17. You may have to refresh your browser to see the results. 
18. Now you can see the results. First you see the waterfall chart for one of the tests. This shows how long it took, if there were any errors in the console, and if the assertion worked. 
19. Go back to the main Synthetics page and try creating an API test.
20. Enter the same URL you used before: https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/
21. Choose a couple of locations. 
22. Add an **Assertion** that **Body** contains **bag**.
23. Refresh the page and you should start seeing results. Click on the result to see the details. 
    