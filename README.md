# ITSL - Image to single line.
Your are gonna need Processing 2 in your system to run it.

To use it you have to tune first the variables in the config section.
-num: This variable sets the number of points and tehrefore lines that the image is gonna be represented in. A higher number will show a more clear image.
its a parameter that requieres some playing to get right.

-fileName: Here goes the name of the image you want to use, remember that it needs to be in the same directory as the code, and remember to add the extension of the image to the name.

-densityAnalysis: This feature is still beeing worked on, so it doesnt work properly yet. But what this feature intedns is to avoid having blank spots in the representation.
Therefore if this is active the program its gonna try to avoid leaving blank spaces, TBH it doesnt work properly yet, but depending on the image and the configuration it can really 
make a difference.

-densityMatrix: This is a config value for the density analysis. This says how many different density values are gonna be stored for the image, in other words in how many different regions
is gonna be divided the image for the densityAnalysis.

-densityMatrixRows: The matrix doesnt have to be squared, so here we define how many rows it has. REMEMBER: When setting the rows and columns the product of both has to be the value
introduced in the densityMatrix config variable.

-densityMatrixCOlumns: The matrix doesnt have to be squared, so here we define how many columns the density matrix has. REMEMBER: When setting the rows and columns the product of both has to be the value
introduced in the densityMatrix config variable.

-densityDecayRate: Here we are gonna put the value by which each cell of the matrix is gonna decrease in importance for each line inside of it. This value represents how much we
decrease the importance of a region per line that has already been drawn inside. This value its pretty tricky!


No more configuration is needed. I recommend you to play wiht those values in order to get the perfect output.
Note that this program is not perfect, the output varies drastically between images, images with a single object and a black background tend to work better than complex images.
If any one has any suggestions feel free to ask me!
![alt text](https://github.com/janestebans/ITSL/blob/main/Examples/withDensityAnalysis.pdf?raw=true)
