In this final step of the integrations section we are going to look at the Datadog UI.

1. Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>.  
1. Navigate to Integrations > Integrations List.
1. Under Installed, you may see tiles for Docker, Nginx, and Redis. Integrations are automatically installed when the Datadog agent sends data from these services, but this can take some time. If you don't see tiles for Redis or Nginx yet, you can install them manually:
    1. Hover over the Redis tile and click the Install button.
    1. Click Install Integration on the Configuration tab.
    1. Close the Redis modal window.
    1. Repeat the last three steps for Nginx.
1. Visit the Dashboards List.
  *You should see several new dashboards, including: Nginx - Overview and Redis - Overview.*
1. Click on the link for the Nginx - Overview dashboard.
  *Note that there's not much here because they're not handling any requests.*
1. Return to the Dashboards page and click on the other dashboard links.
  *See what has been created with each integration installed.*
1. When you are done with this section, run `grademe`{{execute}} to indicate that you are done and are ready for assessment. Then click the **Continue** button.

