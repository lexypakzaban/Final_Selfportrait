ImageEditor greenSourceIE;
ImageEditor backgroundIE;
ImageEditor destinationIE;

//https://bgr.com/2018/03/19/frb-signal-detected-australia-brightest-ever/

void setup()
{
  size(100,100);
  greenSourceIE = new ImageEditor("selfie.jpg");
  backgroundIE = new ImageEditor("space.jpg");
  destinationIE = new ImageEditor(greenSourceIE.width(), greenSourceIE.height());
  greenSourceIE.resizeWindowToImage();
  noLoop();
}
void draw()
{
  // put all the IEs into editing mode
  greenSourceIE.startEditing();
  backgroundIE.startEditing();
  destinationIE.startEditing();
  // loop through all the pixels (x,y)
  for (int y = 0; y < greenSourceIE.height(); y++)
  {
    for (int x = 0; x < greenSourceIE.width(); x++)
    {
    // get the r,g,b of the greenSource's (x,y) pixel
      int r = greenSourceIE.getRedAt(x,y);
      int g = greenSourceIE.getGreenAt(x,y);
      int b = greenSourceIE.getBlueAt(x,y);
      
      greenSourceIE.setRedAt(b,x,y);
      greenSourceIE.setGreenAt(g,x,y);
      greenSourceIE.setBlueAt(r,x,y);
      
      
      
    // find the color distance to pure green (0,255,0) from that pixel
      float cd = sqrt( pow(0-r,2) + pow(255-g,2) + pow(0-b,2));
    // is this close enough to green?
      if (cd < 203)
        // if so, then copy the background color at (x,y) to the destination at (x,y).
      {
        color c = backgroundIE.getColorAt(x,y);
        destinationIE.setColorAt(c,x,y);
      }
        // otherwise, we'll copy the greensource color at (x,y) to the destination at (x,y)
      else
      {
        color c = greenSourceIE.getColorAt(x,y);
        destinationIE.setColorAt(c,x,y);
      }
    }
  }
 // exit editing mode
 destinationIE.stopEditing();
 backgroundIE.stopEditing();
 greenSourceIE.stopEditing();
 // draw the destination image.
 destinationIE.drawAt(0,0);
 save("resultInWindow.png");
  
}
