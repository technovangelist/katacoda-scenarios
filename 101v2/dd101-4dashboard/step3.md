1.  Drag another timeseries widget to the canvas.
1.  Select `system.cpu.user` for the metric.
1.  Now click the **Advanced...** link on the right.
1.  Click the **Add Query +** button and choose `system.cpu.system`.
1.  Now type `a+b` in the **Formula** textbox. <br>
  *Now you have 3 lines on your graph: one representing the metric on the **a** line, one for the **b** line, and then the two added together.*
1.  Uncheck the boxes next to **a** and **b**.<br>
  *The checkboxes control which lines you want displayed on the graph. By unchecking the two source lines, you now have a single line representing the value of the two metrics combined.*
1.  To the right of the a+b formula, you can see the link **as...** Type in `User+System` in the textbox.<br>
  *Hovering over the single line gives you the resulting math, but it's not always obvious what the metric means. We just changed that for this graph. Now when you hover over the metric line you see your new name for the metric.*