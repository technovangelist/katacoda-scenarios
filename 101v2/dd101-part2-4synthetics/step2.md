Let's try to break our page to make the test fail.

1. Run `cd k8s-yaml-files`{{execute}} and then `kubectl delete -f frontend-service.yaml`{{execute}}. This will remove the frontend service pod.
2. Now return to Datadog and click the **Run Test Now** button at the top.
3. It might take a few seconds but you will notice it's still passing. Try clicking the link for the page here: https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com.
4. In the absence of a valid page from a web service, our labs provider shows a page where you can change the port to use. Even though our application is obviously broken, this page still passes the default assertions of our test! So let's update the assertions to be more specific about the content we expect to see at this URL.
5. Return to the Synthetics test page in Datadog. Click the gear icon at the top and choose **Edit test details**. 
6. Click **New Assertion** and ensure that `body` contains the text `Datadog APM Water Management Example`. Click **Save Test**. Then **Run Test Now**.
7. Within a few seconds we should see some alerts on the page. Click on one of them and look at what the problem is.
8. In the lab terminal, restart the front end by running `kubectl apply -f frontend-service.yaml`{{execute}}. And back in the test results page, click **Run Test Now**. The errors should go away.

  _If the Test Results don't update immediately, you can click the **Refresh** button to update them._
