
import ddf.minim.*;

Minim minim;
AudioPlayer song;
//Rewind rewind;
//Forward ffwd;
float myVolume;
int interval;

void setup()
{
  size(512, 200, P3D);
  minim = new Minim(this);
  // load a file from the data folder, use a sample buffer of 1024 samples
  song = minim.loadFile("douwei_sm.wav", 512);
  // buttons for control
  
  //rewind = new Rewind(width/2, 130, 20, 10);
  ////void forward(AudioBuffer buffer, int startAt)
  //ffwd = new Forward(width/2 + 50, 130, 20, 10);
  myVolume = 0;
  interval = 0;
  song.play();
  
}

void draw()
{
  background(0);
  

  // draw the wave form
  // this wav is MONO, so we only need the left channel, 
  // though we could have used the right channel and gotten the same values
  stroke(255);
  line(width/2, 0, width/2, height);
  for (int i = 0; i < song.bufferSize() - 1;  i++)
  {
    line(i, 50 - song.left.get(i)*50, i+1, 50 - song.left.get(i+1)*10);
  }
  // draw the position in the song
  // the position is in milliseconds,
  // to get a meaningful graphic, we need to map the value to the range [0, width]
  float x = map(song.position(), 0, song.length(), 0, width);
  stroke(255, 0, 0);
  line(x, 50 - 20, x, 50 + 20);
  // do the controls

  //rewind.update();
  //rewind.draw();
  //ffwd.update(); 
  //ffwd.draw();
}

void mousePressed()
{

  if(mouseX >width/2){
      song.shiftGain(myVolume, myVolume+10, 1000);
      myVolume+=10;
      println(myVolume);
  }else{
      song.shiftGain(myVolume, myVolume-10, 1000);
      myVolume -= 10;
      println(myVolume);
  }
}

void keyPressed()
{
  if ( key == 'f' )
  {
    // skip forward 1 second (1000 milliseconds)
   song.skip(100);
  }

}