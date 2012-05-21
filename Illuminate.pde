import controlP5.*;
import processing.serial.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

Serial port;
ControlP5 cp5;
Minim minim;
AudioInput input;
FourierAnalyzer analyzer;
FFT fft;

int sliderR = 0;
int sliderG = 0;
int sliderB = 64;

void setup() {
  size(300,300);
  noStroke();
  cp5 = new ControlP5(this);
  port = new Serial(this, "/dev/ttyACM0", 9600);
  //create a new Minim instance
  minim = new Minim(this);  
  //setup FFT stuff
  input = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(input.bufferSize(), input.sampleRate());  
  //set up the fourier analyzer with 64 channels
  analyzer = new FourierAnalyzer(input, fft, 64, fft.specSize()/64);
  
  cp5.addSlider("sliderR")
   .setPosition(100,100)
   .setSize(20,100)
   .setRange(0,128)
   ;

  cp5.addSlider("sliderG")
   .setPosition(150,100)
   .setSize(20,100)
   .setRange(0,128)
   ;

  cp5.addSlider("sliderB")
   .setPosition(200,100)
   .setSize(20,100)
   .setRange(0,128)
   ;
}

void draw() {
  analyzer.update();
  background(sliderR*2,sliderG*2,sliderB*2);
  port.write("H");
  port.write(sliderR);
  port.write(sliderG);
  port.write(sliderB);
}
