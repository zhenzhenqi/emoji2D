abstract class Button
{
  int x, y, hw, hh;
  
  Button(int x, int y, int hw, int hh)
  {
    this.x = x;
    this.y = y;
    this.hw = hw;
    this.hh = hh;
  }
  
  boolean pressed()
  {
    return mouseX > x - hw && mouseX < x + hw && mouseY > y - hh && mouseY < y + hh;
  }
  
  abstract void mousePressed();
  abstract void mouseReleased();
  abstract void update();
  abstract void draw();
}



class Rewind extends Button
{
  boolean invert;
  boolean pressed;
  
  Rewind(int x, int y, int hw, int hh)
  {
    super(x, y, hw, hh);
    invert = false;
  }
  
  // code used to scrub backward in the file
  void update()
  {
    // if the rewind button is currently being pressed
    if (pressed)
    {
      // get the current song position
      int pos = song.position();
      // if it greater than 200 milliseconds
      if ( pos > 200 )
      {
        // rewind the song by 200 milliseconds
        song.skip(-200);
      }
      else
      {
        // if the song hasn't played more than 100 milliseconds
        // just rewind to the beginning
        song.rewind();
      }
    }
  }
  
  void mousePressed()
  {
    pressed = pressed();
    if ( pressed ) 
    {
      invert = true;
      // if the song isn't currently playing, rewind it to the beginning
      if ( !song.isPlaying() ) song.rewind();      
    }
  }
  
  void mouseReleased()
  {
    pressed = false;
    invert = false;
  }

  void draw()
  {
    if ( invert )
    {
      fill(255);
      stroke(0);
    }
    else
    {
      noFill();
      stroke(255);
    }
    rect(x - hw, y - hh, hw*2, hh*2);
    if ( invert )
    {
      fill(0);
      stroke(255);
    }
    else
    {
      fill(255);
      noStroke();
    }
    triangle(x - hw/2, y, x, y - hh/2, x, y + hh/2);
    triangle(x, y, x + hw/2, y - hh/2, x + hw/2, y + hh/2);    
  }  
}

class Forward extends Button
{
  boolean invert;
  boolean pressed;
  
  Forward(int x, int y, int hw, int hh)
  {
    super(x, y, hw, hh);
    invert = false;
  }
  
  void update()
  {
    // if the forward button is currently being pressed
    if (pressed)
    {
      // get the current position of the song
      int pos = song.position();
      // if the song's position is more than 40 milliseconds from the end of the song
      if ( pos < song.length() - 40 )
      {
        // forward the song by 40 milliseconds
        song.skip(40);
      }
      else
      {
        // otherwise, cue the song at the end of the song
        song.cue( song.length() );
      }
      // start the song playing
      song.play();
    }
  }
  
  void mousePressed()
  {
    pressed = pressed();
    if ( pressed ) 
    {
      invert = true;      
    }
  }
  
  void mouseReleased()
  {
    pressed = false;
    invert = false;
  }

  void draw()
  {
    if ( invert )
    {
      fill(255);
      stroke(0);
    }
    else
    {
      noFill();
      stroke(255);
    }
    rect(x - hw, y - hh, hw*2, hh*2);
    if ( invert )
    {
      fill(0);
      stroke(255);
    }
    else
    {
      fill(255);
      noStroke();
    }
    triangle(x, y, x - hw/2, y - hh/2, x - hw/2, y + hh/2);
    triangle(x, y - hh/2, x, y + hh/2, x + hw/2, y);    
  }  
}