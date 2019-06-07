# Creating A Child Span

Creating a child is done by creating a tracer span as `child_of` the parent span.

1.  Try that now and see how it changes our spans by modifying the code to first.py:


    from ddtrace import tracer
    import time

    tracer.configure(hostname='agent', port='8126')

    with tracer.trace('first-span', service='first-service') as span:
      time.sleep(1)
      with tracer.trace('second-span', service='first-service') as span2:
          span2.set_tag('second-tag', '200')
          time.sleep(1)
          with tracer.trace('third-span') as span3:
              span3.set_tag('third-tag', '300')
              time.sleep(1)

After running this code, we can now go into the Datadog interface, and see how the child span looks:

![Child span flame](/technovangelist/scenarios/apmintro1/assets/child-span-flame.png)

If we click into our spans, we can also see the span tags we've set, along with their values.

![Tag values](/technovangelist/scenarios/apmintro1/assets/tag-values.png)

Try putting some delays between our spans to see how this affects your timeline. You'll start to get a feel for how spans show different delays of time.

