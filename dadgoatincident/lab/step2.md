In Datadog, you can create a variety of <a href="https://docs.datadoghq.com/monitors/" target="_datadog">**Monitors**</a> to track the health of your applications and to alert you if action is needed. 

Let's create monitors to track the latency of specific store-frontend, discounts, and advertisements service resources. You will use these monitors later in the activity.

#### Store-frontend Service

1. In the <a href="https://app.datadoghq.com/apm/map?env=ruby-shop" target="_datadog">**Service Map**</a>, click the **store-frontend** node and select **View service overview**.

2. Scroll to the **Endpoints** list and click **Spree::HomeController#index**.

3. Click the **No Monitors or Synthetics Tests** banner near the top and click **New Resource Monitor**. You will be redirected to a new APM monitor page.

4. Notice that the **Select monitor scope** section is already filled out for the respective service and resource.

5. Expand **Set alert conditions**, select **Threshold Alert**. <p>Set the alert as follows: **Alert when `Avg latency` is `above` `1` over the last `1 minute`**.

6. Expand **Say what's happening**, leave the message as is. 

7. Under **Notify your team**, delete `@store-frontend`. You will notice that `@store-frontend` is automatically deleted from the message in step 5. In this case, you do not want to send any notifications.

8. Click **Save** on the bottom right. <p> You will be redirected to the new monitor page. Browse the details. <p> Notice that **Tags** for the resource, service, and environment were automatically assigned to the monitor. These tags will correlate the monitor to the respective Service Page and Resource Page.


#### Discounts Service

1. Continuing from step 8 above, click **New Monitor +** in the top right.

2. Select **APM** from the list of monitor types.

3. Under **Select monitor scope**, select **APM Metrics**. <p>Then, select `discounts-service` as the **Service** and `get_/discount` as the **Resource**.

4. Repeat steps 5 - 8 above, but with the following change. Delete `@discounts-service` in step 7.

#### Advertisements Service

1. Repeat the steps you completed for the discounts service monitor. <p>In step 3, select `advertisements-service` for the **Service** and `get_/ads` for the **Resource**. <p> In step 4, delete `@advertisements-service`.

When you view the monitors in <a href="https://app.datadoghq.com/monitors#/create" target="_datadog">**Monitor** > **Manage Monitors**</a>, you'll notice that their status is `No Data`. Because the monitors are new, it may take a few minutes for the status of the monitors to update. 