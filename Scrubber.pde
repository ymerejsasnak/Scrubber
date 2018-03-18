/*
 -right click on playing sample to stop it, right click on stopped sample to load new
 -either click on empty sample loads
 -no click anywhere to stop (get rid of it)
 -right button on sliders records automation loop (like sample circle control thing)
 -should be able to get rid of clickchecks in display class and just have mousedragged take care of it
 
 more sliders:  
   min speed
   speed range
   changeFactor multiplier (and fix change factor then...more like fine and coarse controls)
   



*/




import beads.*;


Display display;
Sampler sampler;

void setup()
{
  size(800, 600);
  background(50);
  display = new Display();
  sampler = new Sampler();
  ellipseMode(CENTER);
}


void draw()
{
  display.show();
  sampler.updatePosition();
  //sampler.updateVolume();
}