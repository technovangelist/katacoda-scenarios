# Creating Our First Span

1.  Update the code in first.py as follows:

    ```python
    from ddtrace import tracer
    import time

    tracer.configure(hostname='agent', port='8126')

    with tracer.trace('first-span', service='first-service') as span:
      time.sleep(1)
    ```

  *The reason we are using `sleep` is to ensure the tracer has time to flush the trace. This happens asynchronously. If you have a short running application, you will need to ensure there is enough time to flush the trace before the program exits. In most web/API applications, this shouldn't matter, as your program will be long running.*

1.  Open your browser to the Datadog APM trace interface. Find the new service in the list of services, along with the trace and span.
  
    ![APM Services](/technovangelist/scenarios/apmintro1/assets/services.png)

If we click on the trace itself, we can see more information, going into the span view. There are two different ways to view our spans. As a flame graph, and as a list.

   ![Span List](/technovangelist/scenarios/apmintro1/assets/span-list.png)

Lists help to quickly narrow down where the majority of time is spent in your traces.

