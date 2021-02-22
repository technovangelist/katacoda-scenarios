Welcome to the first section of the Introduction to Datadog course.

1. Take a look at the command listed below. See the little curled arrow icon that appears next to it? That means it's a clickable command. Just click it and the command will be copied to the terminal and executed.

    `ls -la`{{execute}}

1. In most of the sections of this course you will find the instructions for the course on the left, a simple editor and file explorer on the top right, and a terminal on the bottom right. Files in the editor are automatically saved.
1. If you ever create a new file in the terminal the file explorer should update within a few seconds. If it doesn't, click the refresh button above the file explorer and the view will update. The command below will create a new file called newfile.txt.

    `touch editor/newfile.txt`{{execute}}

1. Now login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>. On the right side in the terminal you should see login information for the account we created for you. Later if you forget the login information, run `creds`{{execute}} and you will see the information again.
1. Take a look around. We will be trying out many of the sections during this training.
1. Now verify that you are in the right organization. Visit <a href="https://app.datadoghq.com/account/settings#api" target="_datadog">the API Keys section</a>, which you can find in the Global Navigation under **Integrations > APIs**. Expand API Keys and hover over the purple rectangle to reveal the API key we have created for you.
1. In the Training Lab terminal, run the command `echo $DD_API_KEY`{{execute}} to see the API key environment variable. Verify that this is the same API key. You don't have to memorize the entire key. Just making sure that the first and last couple of characters are the same should be good enough to ensure a match.  

    _Note: API and Application keys are different._

    If this is not the same API key that you saw in your Datadog account, you may have been in the wrong organization. You can switch organizations by clicking on the Account menu in the Datadog nav bar and selecting the new organization we created for you.
1. At the end of every section of this course, including this one, run `grademe`{{execute}} when you are finished. Go for it. Run it now.
