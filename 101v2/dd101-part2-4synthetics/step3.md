API tests are great if all you want to test is that an API endpoint or a single page responds in a certain amount of time, but many times you need to test a particular flow through a web app. So let's create a Browser Test to achieve this.

_The test recorder only supports the Google Chrome browser. If you prefer another browser, use Chrome for this lab anyway._

1. Navigate to <a href="https://app.datadoghq.com/synthetics/list" target="_datadog">the Synthetics page</a>. Click the **New Test** button.
2. Click **New Browser Test**.
3. For Starting URL, enter your company's website.
4. We are going to test a few pages on your website, so give the test a good name.
5. Select some locations to run the test from.
6. Click the **Save Details & Record Test** button. 
7. If you haven't run a test before, follow the prompts to install the Datadog Test Recorder browser extension.
8. Navigate around your app for a few steps. Add some assertions to test for the existence of some text on the page. 
9. When done, click **Stop Recording** then **Save & Launch Test**.
10. Wait a few seconds, then click the link to refresh the page.

Think about some of the scenarios you can achieve using Synthetics testing.

When you are done with this section, run `grademe`{{execute}} to indicate that you are done. Then click the **Continue** button.
