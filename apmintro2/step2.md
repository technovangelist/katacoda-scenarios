# Manually Continuing Our Trace Across Systems

If we look at the **thinker.py** in the **step01** directory, we can see that even though our **think** function is wrapped in a trace, we're not continuing or checking for any existing spans.

In order to do that within Flask, we'll need to add **X-Datadog-Trace-Id** and **X-Datadog-Parent-Id** to our requests that go into our private **thinker** API, injecting our **trace_id** and **parent_id**.

Once our request headers make it to the private **thinker** service, we then check to see if they exist and add them into our current span context.

Our Python code for the **thinker** service becomes the following:

    ```python
    @app.route('/')
    def think_microservice():
        # continue the span from the called service
        trace_id = flask_request.headers.get("X-Datadog-Trace-Id")
        parent_id = flask_request.headers.get("X-Datadog-Parent-Id")
        if trace_id and parent_id:
            span = tracer.current_span()
            span.trace_id = int(trace_id)
            span.parent_id = int(parent_id)

        subject = flask_request.args.get('subject')
        thoughts = think(subject)
        return Response(thoughts, mimetype='application/json')
    ```

Notice the **think** function that gets called has a Python decorator. It's wrapping the function call with a span, and inserting the **subject** of the think call into the span's **tag**:

    ```python
    @tracer.wrap(name='think')
    def think(subject):
        tracer.current_span().set_tag('subject', subject)

        sleep(0.5)
        return thoughts[subject]
    ```

Going back to our original **API** application, we also need to instrument and send our trace information in the part where we make our web request:

    ```python
    @app.route('/think/')
    def think_handler():
        thoughts = requests.get('http://thinker:5001/', headers={
            'x-datadog-trace-id': str(tracer.current_span().trace_id),
            'x-datadog-parent-id': str(tracer.current_span().span_id),
        }, params={
            'subject': flask_request.args.getlist('subject', str),
        }).content
        return Response(thoughts, mimetype='application/json')
    ```

If we want, we can restart our containers now, and see how things look with requests being passed across services:

`./start02`{{execute T1}}