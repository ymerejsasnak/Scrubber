import beads.*;


Display display;
Sampler sampler;

void setup()
{
  size(800, 600);
  background(50);
  display = new Display();
  sampler = new Sampler();
}


void draw()
{
  display.show();
  sampler.updatePosition();
}