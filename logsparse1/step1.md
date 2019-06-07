1. From the second terminal tab
Now you can telnet to the right port and send logs interactively to Datadog. If you look at the docker-compose.yml file you will see that port 10520 is being exposed on the localhost as port 10520. So open a telnet connection to that port using the following command:
telnet localhost 10520
Now anything you type at the prompt will be sent to the platform when you press Enter. It's not sent immediately but it should appear in the Log Explorer viewer within a minute. Type the following message and press Enter:
Error - connection refused
Open the Log Explorer and look out for the new log line to appear.
Without updating severity, it defaults to INFO
Without updating severity, it defaults to INFO

What is the status of your log message in the platform right now? You can see status at the top of the log message once you click on it. It shows as Info whereas you would have expected to have this as an Error. To change this we will need to have specific processing rules to extract the severity and the error message.
Navigate to Pipelines and create a new Pipeline. Type service:testtcp for Filter and set the name to Getting Started with Pipelines.
Creating a new pipeline
Creating a new pipeline

Create a new processor in that pipeline. We can use the Grok Parser for this. Set the Test against a sample text box. For the rule, enter
myrule %{word:error.level} - %{data:error.message}
You can see the extraction below. 
Enter a name and click Save.
Next we need a Status remapper to remap the value of the "level" attribute to the global log severity. Set the Status attribute textbox to error.level. Click Save.
Send the Error - connection refused line again.
Navigate to the Log Explorer and search for service:testtcp.
Notice that your old logs are not impacted. All the processors are applied at ingestion so it does not impact already existing logs. This is very important! You cannot make a modification to an existing log.
To see that it works even for JSON formatted logs, send the following line from telnet:
{"error.level":"warning","var1": 10,"error.message":"I told you it would work"}
JSON logs extract data automatically
JSON logs extract data automatically

If it doesn't seem to work, make sure that the log you sent has the correct JSON format. Sometimes copy and paste can introduce 'smart quotes' that aren't recognized by the JSON parser. You can try verifying the JSON with https://jsonlint.com/.
Now that you have created a simple pipeline, let's move on to a few others that you can try on your own.

