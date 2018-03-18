void mousePressed()
{
 display.samplerClickCheck(mouseX, mouseY, mouseButton);
  
}


void mouseDragged()
{
  if (display.smoothSlider.clickCheck(mouseX, mouseY))
  {
    display.smoothSlider.setPosition(mouseY); 
    sampler.setSmoothing((int) display.smoothSlider.getValue()); 
  }
  
  else if (display.speedChangeSlider.clickCheck(mouseX, mouseY))
   {
     display.speedChangeSlider.setPosition(mouseY);
     sampler.setChangeFactor(display.speedChangeSlider.getValue());      
   }
     
   else if (display.directionChangeSlider.clickCheck(mouseX, mouseY))
   {
     display.directionChangeSlider.setPosition(mouseY);
     sampler.setDirectionProbability(display.directionChangeSlider.getValue());
     
   }
}