So far in this course we have looked at getting a better handle on the backend of our application. Synthetics will show us what the frontend looks like to your users.

1. Run `kubectl get pods`{{execute}} until you see all pods are running.
2. Once all of the pods report 1/1 in the Ready column, login to Datadog and navigate to <a href="https://app.datadoghq.com/synthetics/list" target="_datadog">the Synthetics page</a>.
3. If you haven't already enabled this, click **Get Started**. Otherwise, click the **New Test** button.
4. Your two choices are **New API Test** and **New Browser Test**. API Test is good to test endpoints and websites for availability and uptime. Browser Tests are used when you need to record a specific flow through your website and monitor based on that flow. Choose **New API Test**.
5. We want to test the availability of our website. The URL for your copy of the site is here: <pre class="file" data-target="clipboard">https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com</pre>
6. Copy the URL above and paste it into the text box for URL under Define request. Make sure you delete the 'https://' value in that field first, as it's already included in the copied URL.
7. Expand Advanced Options. Notice that you can configure the request to follow redirects, and use custom headers, basic authentication, body, and cookies.
8. Give the test a good name.
9. Now choose some locations, or leave it at All Locations.
10. Click **Test URL** to make a request. If you don't test it, you cannot save the test. The response will be shown as pure text. If you want to see an image of your website, you will have to use the Browser Test option. We will do that later.
11. You can set how often Datadog should run this test under Specify test frequency. For our purposes, select 1m. 
12. Under Define assertions, you'll see that some reasonable assertions have already been made for this test. We'll stick with these for now.
13. Click **Create Test** at the bottom.
14. Pretty soon you should start to see results showing up on the Synthetics page. 

