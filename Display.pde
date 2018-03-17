class Display
{
  final int PADDING = 10;
  
  final int SAMPLE_WINDOW_WIDTH = width - PADDING * 2;
  final int SAMPLE_WINDOW_HEIGHT = 200;
  
  final int SAMPLE_CENTER_Y = SAMPLE_WINDOW_HEIGHT / 2;
  
  final int INFO_BOX_HEIGHT = 25;
  final int INFO_BOX_Y = SAMPLE_WINDOW_HEIGHT + PADDING + 1;
  final int INFO_TEXT_Y = INFO_BOX_Y + INFO_BOX_HEIGHT / 2 + 5;
  
  PGraphics samplePlot;
  
  Display()
  {
    samplePlot = createGraphics(SAMPLE_WINDOW_WIDTH, SAMPLE_WINDOW_HEIGHT);
  }
  
  
  void plotSample()
  {
    long numFrames = sampler.getNumFrames();
    int numChannels = sampler.getNumChannels();
    Sample sample = sampler.getSample();
    
    float[][] frameData = new float[2][(int)numFrames]; 
    sampler.getSample().getFrames(0, frameData);
    
    float framesPerPixel = max(1, numFrames / (float)SAMPLE_WINDOW_WIDTH);
    double msPerPixel = (sample.getLength() / (double)SAMPLE_WINDOW_WIDTH);

    samplePlot.beginDraw();
    samplePlot.background(10);
    samplePlot.stroke(50, 0, 0);
    samplePlot.line(0, SAMPLE_CENTER_Y, SAMPLE_WINDOW_WIDTH, SAMPLE_CENTER_Y);
    samplePlot.stroke(200);
    
    for (int index = 0; index < SAMPLE_WINDOW_WIDTH - 1; index++)
    {      
         /*  
        float[] y1 = new float[numChannels];
        sample.getFrameLinear(index * msPerPixel, y1);
        float[] y2 = new float[numChannels];
        sample.getFrameLinear((index + 1) * msPerPixel, y2);
       
        samplePlot.line(index, map(y1[0], -1, 1, SAMPLE_WINDOW_HEIGHT, 0), index + 1, map(y2[0], -1, 1, SAMPLE_WINDOW_HEIGHT, 0)); 
      /*/
        //catch peaks
        float[] minMaxFrame1 = sampler.getMinMaxInFrames(index * framesPerPixel, framesPerPixel);
        float[] minMaxFrame2 = sampler.getMinMaxInFrames((index + 1)* framesPerPixel, framesPerPixel);
        samplePlot.line(index, map(max(minMaxFrame1[1], minMaxFrame2[1]), -1, 1, SAMPLE_WINDOW_HEIGHT, 0), index, map(min(minMaxFrame1[0], minMaxFrame2[0]), -1, 1, SAMPLE_WINDOW_HEIGHT, 0));
      
    }
    
    samplePlot.endDraw();
  }
  
  
   void show()
  {
    fill(10);
    noStroke();
    rect(PADDING, PADDING, SAMPLE_WINDOW_WIDTH, SAMPLE_WINDOW_HEIGHT);
    
    stroke(50, 0, 0);
    line(PADDING, PADDING + SAMPLE_WINDOW_HEIGHT / 2, PADDING + SAMPLE_WINDOW_WIDTH, PADDING + SAMPLE_WINDOW_HEIGHT / 2);
      
    noStroke();
    rect(PADDING, INFO_BOX_Y, SAMPLE_WINDOW_WIDTH, INFO_BOX_HEIGHT);
    
    if (sampler.isLoaded())
    {
      image(samplePlot, PADDING, PADDING);   
      // playback position
      int playPos = (int) map((float)sampler.getPosition(), 
                               0,       (float)sampler.getLength() - 1, 
                               PADDING, PADDING + SAMPLE_WINDOW_WIDTH - 1);
      stroke(100);
      
      int playPosDraw = min(playPos, PADDING + SAMPLE_WINDOW_WIDTH - 1); // stop it from going past end of window
      
      line(playPosDraw, PADDING, playPosDraw, PADDING + SAMPLE_WINDOW_HEIGHT - 1);
            
      
      //info about sample below the plot
      
      fill(200);
      text(String.format("%.3f", sampler.getLength()) + " ms", PADDING * 2, INFO_TEXT_Y);
      text(sampler.getNumFrames() + " samples", width/2 + PADDING * 2, INFO_TEXT_Y);
      text(sampler.getSampleRate(), width/4 + PADDING * 2, INFO_TEXT_Y);
      
      String channelsText = "";
      if (sampler.getNumChannels() == 1)
      {
        channelsText = "Mono";
      }
      else if (sampler.getNumChannels() == 2)
      {
        channelsText = "Stereo"; 
      }
      text(channelsText, width * .75 + PADDING * 2, INFO_TEXT_Y);
    }
  }
  
  
  void clickCheck(int _mouseX, int _mouseY, int button)
  {
    if (button == RIGHT)
    {
      
      if (_mouseX > PADDING && _mouseX < PADDING + SAMPLE_WINDOW_WIDTH &&
          _mouseY > PADDING && _mouseY < PADDING + SAMPLE_WINDOW_HEIGHT)
      {
        sampler.load();
      }
    }
   
   else if (button == LEFT)
   {
     if (_mouseX > PADDING && _mouseX < PADDING + SAMPLE_WINDOW_WIDTH &&
         _mouseY > PADDING && _mouseY < PADDING + SAMPLE_WINDOW_HEIGHT)
     {
       sampler.toggle(map(_mouseX, PADDING, PADDING + SAMPLE_WINDOW_WIDTH, 0, (float)sampler.getLength()));
     }
   }

  }
  
  
  
}