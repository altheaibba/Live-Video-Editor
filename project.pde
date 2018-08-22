/*
 * A program that customises a live video
 * By Althea Ibba
 *
 * CREDITS (libraries and sample codes used):
 *  - ControlP5 by Andreas Schlegel (2012), http://www.sojamo.de/libraries/controlP5/#examples
 *  - Blending by Andres Colubri, from the Java Examples included in Processing
 *  Also referenced to https://processing.org/reference/
 *
 */

import processing.video.*;
import controlP5.*;

//Declare and initialise variables to be used
Capture video;
ControlP5 cp5;
Knob knobTint;
DropdownList effects;
PImage f1, f2, f3, f4, f5, f6, f7;
int R = 255, G = 255, B = 255, tint = 255, effect = REPLACE;

void setup()
{
  size(600,400); //Set screen size
  
  //Load images to be used for frames
  f1 = loadImage("pframe.png");
  f2 = loadImage("hearts.png");
  f3 = loadImage("flowers.png");
  f4 = loadImage("xmas.png");
  f5 = loadImage("balloons.png");
  f6 = loadImage("curtains.gif");
  
  //Create live video
  video = new Capture(this, 640, 480, 30);
  video.start();
  
  cp5 = new ControlP5(this);
  
  //Create sliders that will control the colour of the video by changing the RGB values
  cp5.addSlider("R").setPosition(480,10).setRange(0,255);  
  cp5.addSlider("G").setPosition(480,20).setRange(0,255);
  cp5.addSlider("B").setPosition(480,30).setRange(0,255);
  
  //Create a knob that will control the tint of the video
  knobTint = cp5.addKnob("tint").setRange(0,255).setValue(255).setPosition(430,5).setRadius(20).setDragDirection(Knob.VERTICAL);
  
  //Create a dropdown menu with a list of all the possible effects that can be used
  effects = cp5.addDropdownList("Effects").setPosition(10,20);
    customize(effects);
  
  //Create a button that will save a screenshot of the video
  cp5.addBang("Save").setPosition(540,360).setSize(40,20);
}

void draw()
{
  if(video.available()) //If a video frame is available to be read..
  {
    video.read(); //Read video
  }
      
  background(0); //Set background to black
  image(video,0,0); //Display video
  
  tint(R,G,B,tint); //Control tint and colour of video using sliders and knob
  blend(video,0,0,width,height,0,0,600,400,effect); //Add effects to video, depending on which one is selected from the dropdown list
  
  //Print instructions on screen
  text("1. Choose an effect:",10,15);
  text("2. Customise the tint and colour",405,70);
  text("3. Choose a frame by pressing any letter from A-F",10,390);
  text("4: Smile, and save your masterpiece!",380,350);

 //If any letter from A-F is pressed, a corresponding frame will appear
 if(keyPressed)
  {
  if(key=='a'||key=='A')
    {
      image(f1,0,0); //Display image
      f1.resize(600,400); //Resize image to fit screen
    }
   else if(key=='b'||key=='B')
    {
      image(f2,0,0);
      f2.resize(600,400);
    }
   else if(key=='c'||key=='C')
    {
      image(f3,0,0);
      f3.resize(600,400);
    }
   else if(key=='d'||key=='D')
    {
      image(f4,0,0);
      f4.resize(600,400);
    }
    if(key=='e'||key=='E')
    {
      image(f5,0,0);
      f5.resize(600,400);
    }
   else if(key=='f'||key=='F')
    {
      image(f6,0,0);
      f6.resize(600,400);
    }
  }
}

void knobTint(int value) //This tells the knob which value it is controlling
{
  tint = color(value); //i.e. the value of the tint of the video
}

void customize(DropdownList ddl) //This customises the dropdown list, setting..
{
  ddl.setBackgroundColor(190); //its background colour (not visible)
  ddl.setItemHeight(20); //the height of its items
  ddl.setBarHeight(15); //the height of its bars
  ddl.getCaptionLabel().set("Effects");//the default name of the dropdown
  for(int i=0; i<8; i++){ //Use a for loop to make it easier..
    ddl.addItem("effect "+i, i); //..to name the items in the dropdown list and set a value to each item
  }
  ddl.setColorBackground(color(32,98,167)); //its background colour (visible)
}

//Tells the dropdown list what to do when an item is selected
void controlEvent(ControlEvent theEvent)
{
  if(theEvent.isController()) //Checks if the Event was triggered from a ControlGroup
  {
    if(theEvent.getController().getValue()==0.0) //eg. if 'Effect 0' is clicked..
    {
      effect = REPLACE; //..change effect to 'REPLACE'
    }
    else if(theEvent.getController().getValue()==1.0)    
    {
      effect = SOFT_LIGHT;
    }
    else if(theEvent.getController().getValue()==2.0)
    {
      effect = MULTIPLY;
    }
    else if(theEvent.getController().getValue()==3.0)
    {
      effect = OVERLAY;
    }
    else if(theEvent.getController().getValue()==4.0)
    {
      effect = ADD;
    }
    else if(theEvent.getController().getValue()==5.0)
    {
      effect = SCREEN;
    }
    else if(theEvent.getController().getValue()==6.0)
    {
      effect = EXCLUSION;
    }
    else if(theEvent.getController().getValue()==7.0)
    {
      effect = SUBTRACT;
    }
  }
}

void Save() //When 'Save' button is clicked..
{ 
  saveFrame("###"); //save screenshot of the video in the sketch folder, with a file name consisting of random digits
}