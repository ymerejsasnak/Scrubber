class Slider
{
  final int HEIGHT = 150;
  final int WIDTH = 50;
  
  int x, y;
  float position; //0 to 100
  float min, max;
  
  
  Slider(int x, int y, int startPos, float min, float max)
  {
    this.x = x;
    this.y = y;
    position = startPos;
    this.min = min;
    this.max = max;
  }
  
  
  float getValue()
  {
    return map(position, 0, 100, min, max); 
  }
  
  
  boolean clickCheck(int _mouseX, int _mouseY)
  {
    return _mouseX > x && _mouseX < x + WIDTH && _mouseY > y  + WIDTH / 2 && _mouseY < y + HEIGHT - WIDTH / 2;
  }
  
  
  void setPosition(int _mouseY)
  {
    position = map(_mouseY, y + WIDTH/2, y + HEIGHT - WIDTH/2, 100, 0); 
  }
  
  
  void display()
  {
    fill(10);
    rect(x, y, WIDTH, HEIGHT);
    stroke(100);
    line(x + WIDTH / 2, y + WIDTH / 2, x + WIDTH / 2, y + HEIGHT - WIDTH / 2); 
    
    int controlPos = (int) map(position, 100, 0, y + WIDTH/2, y + HEIGHT - WIDTH/2);
    fill(150);
    ellipse(x + WIDTH / 2, controlPos, WIDTH / 2, WIDTH / 2);
  }
}