Let's try to break our page to make the test fail.

1. Run `cd k8s-yaml-files`{{execute}} and then `kubectl delete -f frontend-service.yaml`{{execute}}.
2. Now return to Datadog and click the **Run Test Now** button at the top.
3. It might take a few seconds but you will notice it's still passing. Try clicking the link for the page here: https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com.
4. In the absence of a page, our labs provider shows a page where you can change the port to use. So let's change the assertions to ensure that anything other than our water pumps page fails. 
5. Click the gear icon at the top and choose **Edit Test Details**. 
6. Add the assertion for **Body contains Datadog APM Water Management Example**. Click **Save Test**. Then **Run Test Now**.
7. Within a few seconds we should see some alerts on the page. Click on one of them and look at what the problem is.
8. Now restart the front end by running `kubectl apply -f frontend-service.yaml`{{execute}}. And back in the test results page, click **Run Test Now**. The errors should go away.