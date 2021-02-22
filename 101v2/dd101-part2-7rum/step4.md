1. From the [RUM Application List](https://app.datadoghq.com/rum/list), if you click **Explorer** you'll get a more detailed view of recent interactions.
2. Along the top of the graph, you can click and explore the types of data that RUM makes accessible to you:
  1. **Session** groups interactions by user session and includes information about session duration, pages visited, interactions, resources loaded, errors, etc. By clicking on a row here, you can also look at the attributes tab to determine the user IP, browser, and other information.
  2. **Views** shows you what pages users are visiting. Clicking on a row here provides more detail on the view including page load speeds and resources used.
  3. **User Action** lists actions taken by a user such as clicks and any custom actions you've defined with the [`addUserAction` API](https://docs.datadoghq.com/real_user_monitoring/browser/advanced_configuration/?tab=npm#custom-user-actions)
  4. **Errors** provides a list of errors experienced on the user side.
  5. **Resources** provides a list of all resources served to users.
  6. **Long Task** provides a listing of any task in a browser that blocks the main thread for more than 50ms.
6. Further information on the data that RUM collects is available [here](https://docs.datadoghq.com/real_user_monitoring/browser/data_collected/).