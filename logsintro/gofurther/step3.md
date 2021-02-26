# Processing Full Text Logs

Now we have an interesting environment to work with and we can start to make some of the logs more interesting.

1. Navigate to <a href="https://app.datadoghq.com/logs/pipelines" target="_datadog">Logs -> Configuration</a>.
1. Click the **New Pipeline** button at the top right.
1. Set the **Filter** to **service:text_log**. Set the **Name** to **Text Pipeline**.
   ![text pipeline](gofurther/assets/text_pipeline.png)
2. Click the expansion arrow to the left of the new **Text Pipeline**. Now click the **Add Processor** link
3. Choose **Grok Parser** and copy the following into the rules box:
    
    <pre><code>rule %{date("yyyy-MM-dd HH:mm:ss.SSSSSS"):date} %{word:severity} %{word:user} connected to %{notSpace:http.url} it took %{number:http.response_time:scale(0.001)} s and ended up with the %{number:http.status_code} status code user agent used was %{data:http.user_agent}</code></pre>

4. Then copy the following sample log into the sample text box:
    
    <pre><code>2018-09-28 13:43:34.777178 EMERGENCY Alice connected to http://my.website_1.com/path/number/3/?query=param_2&var=foo_1 it took 647000 s and ended up with the 200 status code user agent used was Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.1 Safari/605.1.15</code></pre>
    ![grok parser](gofurther/assets/text_log_grok_parser.png)
5. Expand the rule matched area and notice how the facets were extracted. Review the sample and the rule to see how the Grok Parser works.
6. Name the processor: `Initial log parser` and click **Save**.
7. Add another Processor and choose **Status Remapper**.
8. Set the **Status Attribute** to **severity**. Name the processor: `Remapping severity`. Click **Save**.
   ![remapping severity](gofurther/assets/text_log_remapping_severity.png)

   The final pipeline should look like this:
   ![text_pipeline](gofurther/assets/text_log_final_pipeline.png)
9.  Switch back to the Logs Explorer and click on any of the log messages that start with **WARN** or **DEBUG**, etc.
   
   *Notice that it is parsing all the attributes. Note that processing is only applied at ingestion. Only new logs are impacted. Older logs will remain unchanged.*

11. Close the detail view and hover over the **Status** facet on the left side.
12. Click the gear icon next to Status and choose **Add as column**.

   *Because Status is a facet, you could search for any of the Status values and filter down to just Errors, for instance.*
