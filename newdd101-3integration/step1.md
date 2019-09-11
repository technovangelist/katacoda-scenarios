In this section we are setting up the integrations for Redis and Nginx. They are being installed in the background as you start. When you see the message saying they are installed, start the process below.

1. First we need to install the Datadog Agent. You can do so by running this command: `bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"`{{execute}}.     This is the same command you grabbed from Datadog in the previous section, minus the API key. The key is already set as an environment variable. 
2. 