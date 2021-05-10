The monitors you created should have gathered some data. Because the monitors are linked to the related services and resources, we can see the status of the monitors in the Service Map. If any monitors are in the `ALERT` status, we can start investigating the service from the Service Map.

1. Navigate to <a href="https://app.datadoghq.com/apm/map" target="_datadog">**APM** > **Service Map**</a>. <p> The outlines of the store-frontend, discounts-service, and advertisements-service nodes are red. This means that the monitor that you created for each service endpoint is in the `ALERT` status.

2. Click the **store-frontend** node, then click **Inspect**. <p> Because the discounts service and advertisements service are downstream, let's start investigating those services.  

3. Click the **discounts-service** node, then click **View service overview**. A new tab will open for the discounts-service page.

4. Expand the **Latency** graph by clicking the arrow icon in the top right of the graph. <p> The service latency seems to hover at 2.5 seconds. *That's a noticable and consistent lag in performance!* <p> Close the graph window.

5. Scroll down to the **Endpoints** list and click the **Get /discount** endpoint to view its details. 

6. Click the monitor banner. Notice that the monitor for the endpoint is in the `ALERT` status. 

7. View the **Latency** graph, the **Span Summary**, and the **Traces** list for the endpoint. Sort the Span Summary using the **AVG DURATION** in descending order. <p> Notice that the 2.5 second duration is consistent. 

8. Go back to the Service Map browser tab where you were inspecting the store-frontend.

9. Repeat steps 3 to 7 for the **advertisements-service**. <p> For step 6, click the **Get /ads** endpoint. This is the endpoint you created the monitor for. <p> Notice the **AVG LATENCY** for this endpoint is also about 2.5 seconds. *The **Get /ads** endpoint has the same latency as the **Get /discount** endpoint!* <p> There is something in the build for these endpoints that is causing a consistent latency. Let's check the applications files that define these endpoints to see what may be causing the issue. 

10. Click `discounts-service/discounts.py`{{open}}.

11. Browse the file. Notice that two sleep commands (**Lines 32-33** and **Lines 52-53**) were left after testing. Delete these lines.

12. Click `ads-service/ads.py`{{open}}.

13. Browse the file. Notice that two sleep commands (**Lines 41-42** and **Lines 55-56**) were left after testing. Delete these lines.

14. Go back to the Service Map browser tab where you were inspecting the store-frontend.

15. Click the **store-frontend** node, then click **View service overview**. 

16. Scroll to the **Endpoints** list and sort the list by **AVG LATENCY**. <p> Note: If the **AVG LATENCY** column is not displayed, click the **Options** icon next to the **Search Endpoints** field and select **AVG LANTECY**. <p> Notice the `Spree::HomeController#index`, `Spree::ProductsController#show`, and `Spree::ProductsController#index` have latencies more than 2.5 seconds. 

17. For each endpoint listed in step 15, click the endpoint to view its page. <p> Scroll to the **Span Summary** and sort by **AVG DURATION**. <p> Scroll to the **Traces** list. Click any of the traces to view the details. <p> Notice from the **Span Summary** and **Traces** that the endpoint is dependent on the discounts and advertisements services. <p> For the `Spree::HomeController#index` endpoint, notice the monitor you created is in the alert status. (Note: To save time, you didn't create monitors for the other endpoints. You can also create monitors for the other two endpoints to see how they are affected by fixing the app.)

Deleting the lines in step 11 and 13 that cause the 2.5 second latencies in the discounts and advertisements endpoints should also remove these latencies in the store-frontend endpoints. 