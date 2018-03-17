public class Sampler
{
  
  AudioContext ac;
  SamplePlayer sampler;
  Glide positionUGen;
  
  Sample loadedSample;
  String lastFolder;
  boolean isPlaying = false;
  
  int smoothingMS = 200;
  float changeFactor = .001;
  
  int direction = 1;
  
  
  Sampler()
  {
    ac = new AudioContext();
    ac.start();
    lastFolder = "data";
  }
  
  
  Sample getSample()
  {
    return sampler.getSample();  
  }
 
 
  float getSampleRate()
  {
    return sampler.getSampleRate(); 
  }
  
  
  int getNumChannels()
  {
    return loadedSample.getNumChannels(); 
  }
  
  
  double getPosition()
  {
      return sampler.getPosition(); 
  }
  
  
  long getNumFrames()
  {
    return loadedSample.getNumFrames(); 
  }
  
  
  double getLength()
  {
    return loadedSample.getLength(); 
  }
  
  
  float[] getMinMaxInFrames(float position, float numFrames)
  {
    float[][] frameData = new float[2][(int)numFrames];
    loadedSample.getFrames((int)position, frameData);

    return new float[]{min(frameData[0]), max(frameData[0])};
  }
  
  
  boolean isLoaded()
  {
    return sampler != null;  
  }
  
  
  void load()
  {
    selectInput("load a file", "loader", dataFile(lastFolder), this);
  }
  
  
  public void loader(File selection)
  {
     if (selection == null) {
       println("nothing selected");
     }
     else
     {
       setupSampler(selection.getAbsolutePath());
       lastFolder = selection.getAbsolutePath();
     }
  }
  
  
  void setupSampler(String fileName)
  {
    try
    {
      loadedSample = new Sample(fileName);
    }
    catch (Exception e)
    {
      println("not a valid audio file, try again");
      return;
    }
    
    println(loadedSample.getNumChannels());
    println(loadedSample.getSampleRate());
        
    if (sampler == null)
    {
      sampler = new SamplePlayer(ac, loadedSample); 
      positionUGen = new Glide(ac, 0, smoothingMS);
      sampler.setPosition(positionUGen);
      sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
      sampler.pause(true);
      sampler.setKillOnEnd(false);
      ac.out.addInput(sampler);
    }
    else
    {
      sampler.setSample(loadedSample); 
      sampler.setLoopEnd(new Static(ac, (float)loadedSample.getLength()));
      sampler.pause(true);
    }
    
    display.plotSample();
  }
  
  
  void toggle(float position)
  {
    if (isPlaying)
    {
      sampler.pause(true); 
      isPlaying = false;
    } 
    
    else if (isLoaded())
    {
      isPlaying = true;
      sampler.start(); 
      positionUGen.setValueImmediately(position);
    }
  }
  
  
  void updatePosition()
  {
    perlinDirection();
    if (isPlaying)
    {
      positionUGen.setValue((float)sampler.getPosition() + perlinSpeed() * direction); 
        
      if (sampler.getPosition() > getLength())
      {
        direction = -1; 
      }
      else if (sampler.getPosition() < 0)
      {
        direction = 1;
      }
    }
  }
  
  
  float perlinSpeed()
  {
    
    return map(noise(millis() * changeFactor), 0, 1, 100, 235); 
  }
  
  
  void perlinDirection()
  {
    if (noise(millis() + 1000) >= .7)
    {
      direction = -direction; 
    }
  }
}