# Working with the Pipelines

The current pipelines should look like this:

![pipelines](gofurther/assets/3_pipelines.png)

Now that all the different sources of logs have a unified format, let's create a main processing pipeline to enhance all our logs:

1. Create another pipeline called `Main Processing Pipeline`:
   ![Main pipeline config](gofurther/assets/main_pipeline_conf.png)
2. Add a **Url Parser** processor. Set the **URL** attribute to `http.url` and the **target** attribute to `http.url_details`.
   ![URL Parser](gofurther/assets/urlparser.png)
3. Look at the Logs Explorer to see how this gets parsed out.
4. Create a **User-Agent Parser** processor and set the **User-Agent** attribute to `http.user_agent` and **target** attribute to `http.user_agent_details`:
   ![User Agent](gofurther/assets/useragent.png)
5. Again take a look at the Logs Explorer to see how http.user_agent is parsed.
6. Create attribute categories on the status code with the Category Processor.
7. As shown in the screenshot, add `http.status_code:[200 TO 299]` to the **All events that match** textbox and `2xx` to the **Appear under the value name** textbox. Repeat for `4xx` and `5xx` status codes.
   ![Category processor](gofurther/assets/category_processor.png)

The final pipeline should look like this:

![Main processing pipeline](gofurther/assets/main_processing_pipeline.png)