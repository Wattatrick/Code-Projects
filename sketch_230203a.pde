float dx = 0;
float sx = 5;
float dy = 0;
float sy = 5;

void setup()
{
  size(800,600);
}
void draw()
{
  noStroke();
  fill(0,0,0,5);
  rect(0,0,width,height);
  fill(255);
  circle(dx,dy,50);
  dx = dx + sx;
  if(dx > width || dx < 0)
  {
      sx= sx * (-1);
  }
  dy = dy + sy;
  if(dy > height || dy < 0)
  {
      sy = sy * (-1);
  }
  {
  println(dx);
  }
}
