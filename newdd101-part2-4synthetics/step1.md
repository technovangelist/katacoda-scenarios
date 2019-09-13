So far in this course we have looked at getting a better handle on the backend of our application. Synthetics will show us what the frontend looks like to your users.

1. Login to Datadog and navigate to <a href="https://app.datadoghq.com/synthetics/list" target="_datadog">the Synthetics page</a>.
2. If you haven't already enabled this, click **Get Started**. Otherwise, click the **New Test** button.
3. Your two choices are **New API Test** and **New Browser Test**. API Test is good to test endpoints and websites for availability and uptime. Browser Tests are used when you need to record a specific flow through your website and monitor based on that flow. Choose **New API Test**.
4. We want to test the availability of our website. The URL for your copy of the site is here: https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com
5. Copy the URL above and paste it into the text box for URL under Make a Request.
6. 