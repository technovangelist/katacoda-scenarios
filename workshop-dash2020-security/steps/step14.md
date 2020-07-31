# Defining The Detection Rule Queries

You will see all of the settings from the Log Analytics view have propagated to the rule view.

Review Datadog Documentation on [defining the search query](https://docs.datadoghq.com/security_monitoring/detection_rules#define-the-search-query).

Let’s rename the query to `unique_failed_authentication`.

We will leave the window at 15 minutes.

Let’s create a second query and name it `successful_authentication`.

Let’s change the `@evt.outcome` in the query from `failure` to `success`.

Let’s remove the count unique value.
