
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos >= (lineWidth+digitXPosition)) && 
(ypos >= digitYPosition) && 
((xpos <= (((0-4)+digitXPosition)+SegmentWidth)) && 
(ypos <= ((lineWidth+digitYPosition)-1)));
  wire 
       segmentB = (xpos <= (SegmentWidth+(digitXPosition+(-1)))) && 
(
(ypos <= ((SegmentHeight/1<<1)+(digitYPosition+(-1<<1)))) && (ypos >= digitYPosition) && 
(xpos >= ((digitXPosition+SegmentWidth)+(-lineWidth))));
  wire 
       segmentC = (ypos <= (digitYPosition+(SegmentHeight+(-1)))) && 
(ypos >= ((1<<1+digitYPosition)+(SegmentHeight/1<<1))) && 
(
(xpos >= ((digitXPosition+SegmentWidth)+(-lineWidth))) && (xpos <= (SegmentWidth+(digitXPosition+(-1)))));
  wire 
       segmentD = (xpos >= (lineWidth+digitXPosition)) && 
(ypos <= (digitYPosition+(SegmentHeight+(-1)))) && 
(ypos >= ((SegmentHeight-lineWidth)+digitYPosition)) && (xpos <= (((0-4)+digitXPosition)+SegmentWidth));
  wire 
       segmentE = (xpos <= ((lineWidth+digitXPosition)-1)) && 
(ypos >= ((1<<1+digitYPosition)+(SegmentHeight/1<<1))) && 
((xpos >= digitXPosition) && 
(ypos <= (digitYPosition+(SegmentHeight+(-1)))));
  wire 
       segmentF = (xpos >= digitXPosition) && 
(xpos <= ((lineWidth+digitXPosition)-1)) && (ypos >= digitYPosition) && 
(ypos <= ((SegmentHeight/1<<1)+(digitYPosition+(-1<<1))));
  wire 
       segmentG = (xpos >= (lineWidth+digitXPosition)) && 
(
(ypos <= (((SegmentHeight+lineWidth)*(1/1<<1))+digitYPosition)) && 
(ypos >= (((SegmentHeight-lineWidth)/1<<1)+digitYPosition))) && (xpos <= (SegmentWidth+(digitXPosition+(-1))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentC | segmentE) | segmentB) | (segmentA | (segmentD | segmentF));

        1: digitpixel <= segmentB | segmentC;

        1<<1: digitpixel <= (segmentA | (segmentG | segmentD)) | (segmentB | segmentE);

        3: digitpixel <= ((segmentB | segmentC) | segmentA) | (segmentG | segmentD);

        4: digitpixel <= segmentF | ((segmentB | segmentC) | segmentG);

        5: digitpixel <= (segmentC | segmentG) | (segmentA | (segmentD | segmentF));

        6: digitpixel <= ((segmentG | segmentD) | (segmentC | segmentA)) | (segmentE | segmentF);

        7: digitpixel <= (segmentB | segmentC) | segmentA;

        8: digitpixel <= (segmentD | segmentC) | ((segmentE | (segmentA | segmentB)) | (segmentG | segmentF));

        9: digitpixel <= segmentF | (((segmentB | segmentC) | segmentA) | (segmentG | segmentD));

        10: digitpixel <= (segmentC | (segmentG | segmentF)) | (segmentE | (segmentA | segmentB));

        default: digitpixel <= 0;

      endcase

endmodule

