import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.*;
import processing.pdf.*;  
import processing.serial.*;
import java.lang.Math;


int percPerDivision = 20;

public class MyPoint{
 int xS;
 int yS;
 int diff;
 color pixelColor;
 PVector vector;
}

public class MyLine{
  color lineColor;
  int px;
  int py;
  int xS;
  int yS;
}



//CONFIG
int num = 60000; //80k works well
String fileName = "sculpture4.jpg";
boolean densityAnalysis = true;
int densityMatrix = 16;
int densityMatrixRows = 4;
int densityMatrixColumns = 4;
float densityDecayRate = 0.2;
//END CONFIG

PImage img;
int[] rank = new int[num];
int[] xS = new int[num];
int[] yS = new int[num];

color silver = color(246,246,250);
color dblue = color(112,83,145);
color dblue2 = color(185,181,252);
color black = color(0, 0, 0);
color white = color(255, 255, 255);



//New vars
int pointCounter = 0;
ArrayList<MyPoint> points;
int percCounter = 0;
int percDivCounter = 0;
int size;
int totalPercentage = 0;

int lineCounter = 0;
ArrayList<MyLine> lines;
int lineDrawerCounter = 0;
boolean saved = false;
int DRAW_CONST = 1000;

//ZOOM
float zoom = 1;
final static float inc = .05;
final static short sz  = 30;

//TRANSLATE
int transX = 0;
int transY = 0;
int moveConst = 50;

void setup() {

  //frame.setResizable(true);
  img = loadImage(fileName); //choose image here
  size(img.width,img.height);
  img.loadPixels();
  
  if(densityAnalysis){
   
    boolean found = false;
    
    //Width
    while(!found){
    
      if(width % densityMatrixColumns == 0){
        found = true;
        println("New width " + width);
      }else{
        println("WIDTH de " + width + "  a " + (width - 1) );
        width--;
      }
    
    }
    
   found = false;
   
   //Height
   while(!found){
    
      if(height % densityMatrixRows == 0){
        found = true;
        println("New height " +  height);
      }else{
        height--;
      }
    
    }
    
  }
  
  //We load the image after calculating new height and width to avoid messing up with the actual position of the pixels!!!!!
  size = height * width;
  println("New size = " + size);
  
  int percPadding = size / percPerDivision;
  points = new ArrayList();
  
  float centerR;
  float centerG;
  float centerB;
  
  float upR;
  float upG;
  float upB;
  
  float downR;
  float downG;
  float downB;
  
  float leftR;
  float leftG;
  float leftB;
  
  float rightR;
  float rightG;
  float rightB;
   
  //Density
  int densityGroups = size / densityMatrix;
  int[] density = new int[densityGroups];
  int densityXaxisGroupNumber = width / densityMatrixColumns;
  
  //Start all values at 0
  for (int i = 0; i < densityGroups; i++){    
   density[i] = 0; 
  }
  

  for (int y = 0; y < height; y++) {

    for (int x = 0; x < width; x++) {

      int loc = x + y * width;

      if(loc < img.pixels.length - 1){   
        
       float total1 = red(img.pixels[loc]) + green(img.pixels[loc]) + blue(img.pixels[loc]);
       float total2 = red(img.pixels[loc+1]) + green(img.pixels[loc+1]) + blue(img.pixels[loc+1]);
       
       centerR = red(img.pixels[loc]);
       centerG = green(img.pixels[loc]);
       centerB = blue(img.pixels[loc]);
       
       //Check left
       if(x > 0){        
         leftR = red(img.pixels[loc - 1]);
         leftG = green(img.pixels[loc - 1]);
         leftB = blue(img.pixels[loc - 1]);
       }else{      
         leftR = centerR;
         leftG = centerG;
         leftB = centerB;
       }
       
       //Check right
       if(x < width -1 ){
         rightR = red(img.pixels[loc + 1]);
         rightG = green(img.pixels[loc + 1]);
         rightB = blue(img.pixels[loc + 1]); 
       }else{
         rightR = centerR;
         rightG = centerG;
         rightB = centerB;
       }
       
       //Check up
       if(y > 0){           
         upR = red(img.pixels[loc - width]);
         upG = green(img.pixels[loc - width]);
         upB = blue(img.pixels[loc - width]);         
       }else{         
         upR = centerR;
         upG = centerG;
         upB = centerB;
       }
       
       
       //Check down
       if(y < height - 1){
         downR = red(img.pixels[loc + width]);
         downG = green(img.pixels[loc + width]);
         downB = blue(img.pixels[loc + width]);  
       }else{
         downR = centerR;
         downG = centerG;
         downB = centerB;
       }
       
       //Down
       float diff = Math.abs(centerR - downR) + Math.abs(centerG - downG) + Math.abs(centerB - downB);
       
       //Up
       diff = diff + Math.abs(centerR - upR) + Math.abs(centerG - upG) + Math.abs(centerB - upB);
       
       //Right
       diff = diff + Math.abs(centerR - rightR) + Math.abs(centerG - rightG) + Math.abs(centerB - rightB);
       
       //Left
       diff = diff + Math.abs(centerR - leftR) + Math.abs(centerG - leftG) + Math.abs(centerB - leftB);
      
       color auxColor = img.pixels[loc];
       
       if(densityAnalysis){
               
         int densityX = x / densityMatrixColumns;
         int densityY = y / densityMatrixRows;
         int densityLoc = densityX + densityY * densityXaxisGroupNumber;
         //println(" y " + y +"  width " +  width + "   densityY  " + densityY + "   densityX " + densityX + "    densityLoc   " + densityLoc);
         diff = diff - diff * densityDecayRate * density[densityLoc];
         density[densityLoc]++;
              
       }
       
       
       MyPoint auxPoint = new MyPoint();
       auxPoint.xS = x;
       auxPoint.yS = y;
       auxPoint.diff = int(diff);
       auxPoint.pixelColor = auxColor;
       points.add(auxPoint);
       pointCounter++;
       percCounter++;

       if(percCounter > percPadding){

         percDivCounter++;
         int auxPerc = percDivCounter * (100 / percPerDivision);
         println("Point analysis: " + auxPerc + "%");
         percCounter = 0;

       }

      }

    }

  }

  println("Sorting");
  sort();
  lines = new ArrayList<MyLine>();
  lines2();

}


void sort(){

  Collections.sort(points, new Comparator<MyPoint>() {
            @Override
            public int compare(MyPoint o1, MyPoint o2) {
                return o2.diff - o1.diff;
            }
        });

}


void draw() {

  
  noStroke();
  background(0);
  stroke(0);
  strokeWeight(0.1);
  
  //ZOOM
  if (mousePressed)
    if      (mouseButton == LEFT)   zoom += inc;
    else if (mouseButton == RIGHT)  zoom -= inc;
  
  //Camera movement
  if(keyPressed){
    
    switch(key){
     
     case 'w':
     case 'W':
     transY += moveConst;
      break;
     
     case 'a':
     case 'A':
     transX += moveConst;
      break;
          
     case 's':
     case 'S':
     transY -= moveConst;
      break;
      
     case 'd':
     case 'D':
     transX -= moveConst;     
      break;
      
    }             
         
  }

  translate(transX, transY);  

  //translate(width>>1, height>>1);
  scale(zoom);
  
       
  if(lineDrawerCounter < lineCounter){    
    
    for(int i = 0; i < lineDrawerCounter; i++){
      
      stroke(lines.get(i).lineColor);
      line(lines.get(i).px, lines.get(i).py, lines.get(i).xS, lines.get(i).yS);
        
    }       
            
  }
   
   
  if(lineDrawerCounter >= lineCounter && !saved){
    
    saved = true;
    beginRecord(PDF, "filename.pdf");
    noStroke();
    background(0);
    stroke(0);
    strokeWeight(0.1);
    
    for(int j = 0; j < lineCounter; j++){
      
      stroke(lines.get(j).lineColor);
      line(lines.get(j).px, lines.get(j).py, lines.get(j).xS, lines.get(j).yS);
    
    }
        
    println("Saving");
    save("filename.pdf");  
    endRecord();
    //exit();
            
  }
  
  if(saved && lineDrawerCounter > lineCounter){
     lineDrawerCounter = 0;
  }
  
  lineDrawerCounter += DRAW_CONST;
  
}


void lines2(){

  int drawingPerc = 0;
  int drawingDiv = num / 100;
  int drawingCounter = 0;
  
  float closest;
  ArrayList<MyPoint> vectors = new ArrayList<MyPoint>();
  color[] colors = new color[num];

  println("Creating vectors");
  for(int i = 0; i < num; i++) {
    MyPoint auxPoint = points.get(i);
    auxPoint.vector = new PVector(auxPoint.xS, auxPoint.yS);
    vectors.add(auxPoint);
    //colors.add();
    colors[i] = points.get(i).pixelColor;
  }
  int a=0;
  int b=0;
  float curDist=width;

  println("Drawing");
  //34
  while(vectors.size() > 5){
    closest=width;
    float px = vectors.get(a).xS;
    float py = vectors.get(a).yS;
    vectors.remove(a);
    for(int p=0;p<vectors.size();p++){
      curDist=dist(px,py,vectors.get(p).xS,vectors.get(p).yS);
      if(curDist<closest){
          closest=curDist;
          b=p;
      }
    }

  MyLine auxLine = new MyLine();
  auxLine.lineColor = vectors.get(b).pixelColor;
  auxLine.px = int(px);
  auxLine.py = int(py);
  auxLine.xS = vectors.get(b).xS;
  auxLine.yS = vectors.get(b).yS;
  lines.add(lineCounter, auxLine);
  lineCounter++;

  a=b;

  drawingCounter++;
  if(drawingCounter > drawingDiv){

     drawingCounter = 0;
     drawingPerc++;
     println("Creating lines: "+ drawingPerc + "%");

  }

  }

  endRecord();

}

