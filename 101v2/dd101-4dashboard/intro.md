So far in our hands-on sections, you have seen many of the metrics that are being collected and some of the default dashboards that are available. In this section we will start looking at building a dashboard.

Datadog offers two types of dashboards: screenboards and timeboards.

<a href="https://docs.datadoghq.com/dashboards/screenboards/" target="_datadaog">Screenboards</a> are free-form and can include a variety of objects such as images, graphs, and logs. They are commonly used as status boards or storytelling views that update in real-time or represent fixed points in the past.

<a href="https://docs.datadoghq.com/dashboards/timeboards/" target="_datadog">Timeboards</a> have automatic layouts, and represent a single point in time—either fixed or real-time—across the entire dashboard. They are commonly used for troubleshooting, correlation, and general data exploration.

In this lab, we'll use a timeboard to monitor a load balancer in front of 3 webservers.

The objectives for this section are:

1. Create a new dashboard
2. Understand what value the various widgets offer
3. Configure dashboard widgets
