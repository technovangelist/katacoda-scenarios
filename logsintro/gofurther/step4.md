# Processing JSON Logs

If you look at the log files our application is creating, you'll notice there is a text file and a json file. Here is an example line from the json file:

<pre><code>{
  "user_agent": "Mozilla/5.0%2520(Windows%2520NT%25206.1;%2520Win64;%2520x64)%2520AppleWebKit/537.36%2520(KHTML,%2520like
%2520Gecko)%2520Chrome/67.0.3396.99%2520Safari/537.36", 
"response_time": 7721, 
"url": "http://my.website_1.com/path/number/2/?query=param_2&var=foo_2", 
"status_code": "503", 
"user": "John", 
"message": "A user connected to a URL", 
"my_date": "2018-09-28 13:06:24.427020", 
"severity": "CRITICAL"
}
</code></pre>

Datadog will see that JSON blog and automatically parse it. But sometimes we want the JSON to be formatted differently. Perhaps you have a common naming convention and some log sources don't use them. For instance, you may have one log that specifies user_id, and others with user.id, user-id, userid, and uid.  A JSON processor can do the remapping necessary to achieve a consistent user.id.

1. Return to the Pipelines view and create a New Pipeline.
2. Name the pipeline: `JSON pipeline`. Set the filter to `Service:json_log`.
3. Add a **Remapper** processor and set the attribute to remap to `user_agent` and the **target** attribute to `http.user_agent`. Name the processor `Remap User Agent`.
4. Repeat, adding **Remapper** processors for the following attributes:

   * url on http.url
   * status_code on http.status_code
   The final pipeline should look something like this:
   ![Final pipeline](gofurther/assets/jsonlogfinalpipeline.png)

   and transform this log:


  <pre><code>{  
   "user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.1 Safari/605.1.15",
   "response_time":9611,
   "url":"http://my.website_2.com/path/number/2/?query=param_2&var=foo_2",
   "status_code":"403",
   "message":"A user connected to a URL",
   "user":"Alice",
   "my_date":"2018-07-10 21:44:27.891783",
   "severity":"DEBUG"
}
  </code></pre>

   into this log:


  <pre><code>{
    "http": {
        "status_code": 404,
        "url": "http://my.website_1.com/path/number/3/?query=param_1&var=foo_2",
        "user_agent": "Mozilla/5.0%2520(X11;%2520Linux%2520x86_64;%2520rv:60.0)%2520Gecko/20100101%2520Firefox/60.0",
    },
    "my_date": "2018-07-10 21:45:58.065181",
    "response_time": 5874,
    "severity": "CRITICAL",
    "url": "http://my.website_1.com/path/number/3/?query=param_1&var=foo_2",
    "user": "Alice"
}
  </code></pre>


Take a look at the Logs Explorer to see this in action
