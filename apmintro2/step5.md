# Adding and Instrumenting a Datastore

If we open up the **step04** folder, we can see how we've added a SQLite datastore to the infrastructure of our code.

Now, instead of using a **namedtuple**, we use a SQLAlchemy backend, instrumented in a **bootstrap.py** file, and a formal **models.py** file too. Let's open these up, and see what things look like.

`step04/models.py`:

```python
from flask_sqlalchemy import SQLAlchemy


# don't initialize the SQLAlchemy immediately
db = SQLAlchemy()


class Thought(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    quote = db.Column(db.String(128), unique=True)
    author = db.Column(db.String(32))

    subject = db.Column(db.String(32))

    def __init__(self, quote, author, subject):
        self.quote = quote
        self.author = author
        self.subject = subject

    def serialize(self):
        return {
            'id': self.id,
            'quote': self.quote,
            'author': self.author,
            'subject': self.subject
        }
```

`step04/bootstrap.py`:

```python
from flask import Flask
from ddtrace import tracer, patch
patch(sqlalchemy=True,sqlite3=True)
from models import Thought, db


# configure the tracer so that it reaches the Datadog Agent
# available in another container
tracer.configure(hostname='agent')


def create_app():
    """Create a Flask application"""
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)
    initialize_database(app, db)
    return app


def initialize_database(app, db):
    """Drop and restore database in a consistent state"""
    with app.app_context():
        db.drop_all()
        db.create_all()

        db.session.add(Thought(quote='My religion consists of a humble admiration of the illimitable superior spirit who reveals himself in the slight details we are able to perceive with our frail and feeble mind.',
                               author='Albert Einstein',
                               subject='religion'))

        db.session.add(Thought(quote='For a successful technology, reality must take precedence over public relations, for Nature cannot be fooled.',
                               author='Richard Feynman',
                               subject='technology'))
        db.session.add(Thought(quote='One is left with the horrible feeling now that war settles nothing; that to win a war is as disastrous as to lose one.',
                               author='Agatha Christie',
                               subject='war'))
        db.session.add(Thought(quote='Life grants nothing to us mortals without hard work.',
                               author='Horace',
                               subject='work'))
        db.session.add(Thought(quote='Ah, music. A magic beyond all we do here!',
                               author='J. K. Rowling',
                               subject='music'))
        db.session.add(Thought(quote='I think that God in creating Man somewhat overestimated his ability.',
                               author='Oscar Wilde',
                               subject='mankind'))
        db.session.commit()
```

Notice how we just added a **patch()** to our model, and defined where on the network the Datadog Agent lives.

With this small addition of code, we have visual feedback on how our ORM system works, and where the bottlenecks might be.

Even though we've been using a contrived example to demonstrate how to instrument traces, let's add a layer of cache next and see how it speeds up our processes, and how tracing allows for transparency in our caching systems too.

Stop the previous section's **docker-compose** using the **CTRL-C** keyboard sequence. Then run the following commands to ensure it's stopped.

`docker-compose stop;docker-compose rm -f`{{execute T1}}

Then run:

`./start04`{{execute T1}}

Now let's debug using our new ORM.

Run the following commands:

`curl http://localhost:5000/think/?subject=mankind`{{execute T2}}

`curl http://localhost:5000/think/?subject=war`{{execute T2}}

And again, let's raise an error in our system:

`curl http://localhost:5000/think/?subject=art`{{execute T2}}

We can look at the results generated back in the Datadog APM interface, and see how our requests have now propagated:

![serialize error](/technovangelist/scenarios/apmintro2/assets/serialize-error.png)

Besides seeing our requests propagated in the trace list, notice how we can see exactly where our errors have been raised in our distributed system.

The error is happening in the **thinker** microservice, when we don't have a matching **Thought** for a subject.

One fix could be adding a default thought for any subject. Maybe that's something we'll have to think about?

Something like this should be a fix for our problematic code:

    ```python
    @tracer.wrap(name='think')
    def think(subject):
        tracer.current_span().set_tag('subject', subject)

        sleep(0.5)
        quote = Thought.query.filter_by(subject=subject).first()
        if quote is None:
            return Thought(quote='Hmmm, that\'s something I\'ll need to think about.',
                          author='The Machine',
                          subject=subject)
        return quote
    ```

Let's try running that now, and see whether it's a fix for our error:

`curl http://localhost:5000/think/?subject=art`{{execute T2}}
