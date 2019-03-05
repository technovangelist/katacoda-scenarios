* Login to your <a href="https://app.datadoghq.com" target="_datadog">Datadog account</a>.
* From the menu, create a **New Notebook**.
* Click the gear icon to the left of the first box and choose to **Insert Markdown Above**.<br>
  *Let's start by describing the increased load on the servers caused by new traffic. *
* Come up with a description for how you noticed that traffic was increasing on your web environment.<br>
  *Pretend that you didn't cause it with a script.*
* Start adding other graphs that might be related to your notebook.<br>
  *Notice that the default graph shows <strong>avg:system.load.1{&ast;}</strong> right at the same time that **heavy** was running.  Look for patterns that support your hypothesis. When you discover a good story, remove the graphs you aren't using.*
* Click the clock icon on the top of each graph. <br>
  *You can assign a time period for this graph that is different from the global time. Sometimes its useful to show what performance was like yesterday or last week and then this week.*
* Now click on the grid icon just below the clock. <br>
  *If you don't see it, make sure you are hovering over the graph. Here you can change the size of the graph as well as have it create a graph for each host or anything else associated with a tag.*
* Choose an apache metric that represents what was wrong. 
* Adust the time period to ensure you have the problem in view. 
* Configure the graph to ensure you are showing the problem.
* Try creating another Notebook for the problem with the server that went down.

**There is nothing to grade for this one, so when you have tried it out, you can move on to the next section**