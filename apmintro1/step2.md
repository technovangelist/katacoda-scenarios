# Configuring the Tracer

Now we have a way to ship our Traces from Python and can jump in and configure a program to be instrumented.

1. Initialize and configure the Python bindings to ship to our local Docker container by adding the following to `first.py` in the code editor:


    from ddtrace import tracer

    tracer.configure(hostname='agent', port='8126')

  *Note: Normally you won't need to specify the port and hostname as it defaults to port 8126 on the localhost. Since the Agent is running in a different container, we need to specify it here.*

  *When you click save, then switch back to the console where docker-compose is running, you should see that the web container noticed the change. The Agent will mention that it has no tracked services, so we will set that up next.*

