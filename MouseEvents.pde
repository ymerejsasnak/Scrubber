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
}