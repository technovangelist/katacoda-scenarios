Welcome to the first section of the Introduction to Datadog course.

1. Take a look at the command listed below. See the little curled arrow icon that appears next to it? That means its a clickable command. Just click it and the command will be copied to the terminal and be executed.

    `ls -la`{{execute}}

2. In most of the sections of this course you will find the instructions for the course on the left, a simple editor and file explorer on the top right, and a terminal on the bottom right.
3. If you ever create a new file in the terminal the file explorer should update within a few seconds. If it doesn't, click the refresh button above the file explorer and the view will update.

    `touch editor/newfile.txt`{{execute}}

4. Now login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>. You should have received an email letting you know about the organization we have created for you. Again, we use a separate org to ensure that you don't pollute your production environment.
5. Take a look around. We will be trying out many of the sections during this training.
6. Now verify that you are in the right account. Visit <a href="https://app.datadoghq.com/account/settings#api" target="_datadog">the API keys section</a>, expand API Keys and identitfy your API key.
7. In the terminal, run the `env`{{execute}} command and look for the API Key environment variable. Verify that they are the same. You don't have to memorize the entire key. Just making sure that the first and last couple of characters are the same should be good enough to ensure a match.
    _Note: API and APP keys are different._
8. At the end of every section of this course, including this one, run `finish`{{execute}} when you are finished. Go for it. Run it now.
xxx
