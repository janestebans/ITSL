# ITSL - Image to single line.
Your are gonna need Processing 2 in your system to run it.

This software exports the results as pdf, that can later be imported to illustrator, there if you want you can delete the background and export as image.

## How it works
The software makes an average between a pixel and its soroundings a puntuation is calculated and stored. The all the pixels are sorted from higher points to lowest, meaning that the pixels with the lowest points are the "less relevant" while the ones with the higher puntuation are usually edges that define the shape of the image.
Once they are sorted only the 'x' most relevant are drawn. This 'x' is selected by the user. Playing with this x can result in surprising results.


## Config variables
To use it you have to tune first the variables in the config section.
- num: This variable sets the number of points and tehrefore lines that the image is gonna be represented in. A higher number will show a more clear image.
its a parameter that requieres some playing to get right.

- fileName: Here goes the name of the image you want to use, remember that it needs to be in the same directory as the code, and remember to add the extension of the image to the name.

- densityAnalysis: This feature is still beeing worked on, so it doesnt work properly yet. But what this feature intedns is to avoid having blank spots in the representation.
Therefore if this is active the program its gonna try to avoid leaving blank spaces, TBH it doesnt work properly yet, but depending on the image and the configuration it can really 
make a difference.

- densityMatrix: This is a config value for the density analysis. This says how many different density values are gonna be stored for the image, in other words in how many different regions
is gonna be divided the image for the densityAnalysis.

- densityMatrixRows: The matrix doesnt have to be squared, so here we define how many rows it has. REMEMBER: When setting the rows and columns the product of both has to be the value
introduced in the densityMatrix config variable.

- densityMatrixCOlumns: The matrix doesnt have to be squared, so here we define how many columns the density matrix has. REMEMBER: When setting the rows and columns the product of both has to be the value
introduced in the densityMatrix config variable.

- densityDecayRate: Here we are gonna put the value by which each cell of the matrix is gonna decrease in importance for each line inside of it. This value represents how much we
decrease the importance of a region per line that has already been drawn inside. This value its pretty tricky!

IMPORTANT: Density analysis reduces randomness of patterns!


No more configuration is needed. I recommend you to play wiht those values in order to get the perfect output.
Note that this program is not perfect, the output varies drastically between images, images with a single object and a black background tend to work better than complex images.
If any one has any suggestions feel free to ask me!

KNOWN BUGS: Depending on the image it can draw non important lines for example background lines, therefore if amount of lines introduced its to big the software might paint irrelevant lines.



## Examples (this examples have been imported to photoshop and colors have been edited):

<img src="https://github.com/janestebans/ITSL/blob/main/Examples/heart.png" align="center" height="750" width="750" ></img>
<img src="https://github.com/janestebans/ITSL/blob/main/Examples/sinatra.png" align="center" height="750" width="750" ></img>
<img src="https://github.com/janestebans/ITSL/blob/main/Examples/sub37.png" align="center" height="550" width="1000" ></img>


<div class="row">
  <div class="col-md-2 text-center">
    <div class="title">Without density analysis</div>
    <a href="url"><img src="https://github.com/janestebans/ITSL/blob/main/Examples/withoutDensityAnalysis.jpg" align="center" height="550" width="550" ></a>
  </div>
  <div class="col-md-2 text-center">
    <div class="title">With density analysis</div>
    <a href="url"><img src="https://github.com/janestebans/ITSL/blob/main/Examples/withDensityAnalysis.jpg" align="center" height="550" width="550" ></a>
  </div>
</div>

