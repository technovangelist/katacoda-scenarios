# Our Monolith Web Application

Our legacy monolith application uses Ruby on Rails and Spree Commerce to sell cool hats. Our marketing team is eager to run advertisements and coupons to boost our sales. To support them, we'll be introducing a coupon and advertising service so they can independently iterate on this service quickly.

We'll use `docker-compose` to start it up. There's a prebuilt Rails Docker container image, along with the new Python / Flask microservice which handle our Coupon codes and Ads which display in the store.

In this workshop, we're going to spin up and instrument our application and connect their APM tracing data to observe how these services are connected to each other.

We'll focus on thinking through what observability might make sense in a real application, and see how setting up observability works in practice.

Our application should be cloned from Github in this scenario, and if we change into the directory, we should be able to start the code with the following:

```
$ cd /ecommerce-observability/docker-compose-files
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f docker-compose-fixed-instrumented.yml up
```

Once our images are pulled, we should be able to jump into and view the application within Katacoda:

https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/

Try browsing around to explore the application which should look like this:

![storedog](https://raw.githubusercontent.com/DataDog/ecommerce-workshop/master/images/storedog.png)

Next, let's gather a baseline with APM tracing.
