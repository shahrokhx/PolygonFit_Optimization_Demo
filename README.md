# Polygon Fit Optimization Demo
An interactive (and extremely efficient) demo toolbox solving an interesting, yet challenging, constrained optimization problem.



| <div style="text-align:center"><span style="color:black; font-family:Georgia; font-size:1em;">Developed by Shahrokh Shahi</span></div>|
|:----------|
| <div style="text-align:center"><span style="color:black; font-family:Georgia; font-size:1em;">Georgia Institute of Technology <br> College of Computing <br> 2018</span></div>|
| <div style="text-align:center"><span style="color:black; font-family:Georgia; font-size:1em;"><a  href="https://www.sshahi.com" target="_blank">www.sshahi.com</span></div>|


<hr style="border:2px solid gray;">

#### Details:
> This toolbox is part of the optimization visualizing series that I developed during the optimization class at Georgia Tech. More details about these toolboxes and packages is presented in <a href="http://www.sshahi.com/projects/tlbx-2-opt/" target="_blank">this blog post</a>.



<p align="justify">
This toolbox provides a demo of an interesting constraint optimization problem:<br>
<b><marked>Find the coordinates of an n-sided polygon of greatest area, which will fit inside a given ellipse.</marked></b><br>
This was a challenging bonus problem in an optimization course at Georgia Tech, which the best record before this implementation could solve at most n=6, after more than an hour computation. However, this implementation was successfully tested for n<=20 with computational times less than a minute. Additionally, I also developed a simple graphical user interface to increase the flexibility of testing and visualization. 
</p>

<p align="justify">
Within this toolbox, you can modify the ellipse equatio, also see the coordinates, Lagrange multipliers values, and a visualization of the optimum solution. This is also a visual proof of the fact that this problem has infinite solutions and each time new coordinates (and thus polygon) will be obtained, where all have the maximum area inside the peripheral ellipse. 
</p>

<p align="justify">
This toolbox can also serve as an effective educational demo in the optimization courses. 
</p>


----

### Sample run

![](img/exec_anim.gif)

----

### Install the toolbox on MATLAB
- Run "Polygon Fit Optimization.mltbx" in MATLAB and complete the installation
- Run "polyfitgui" in MATLAB command window
- Enjoy! (The app will be run with a pre-set values as an example)

---

### Notes
-	The source codes are also available in __src__ folder.
-	Please note that the GUI is built and tested in Windows; there might be some visual differences in macOS (for instance, the test may appear smaller)
-	Please feel free to contact me if there is any problem or questions. 
----