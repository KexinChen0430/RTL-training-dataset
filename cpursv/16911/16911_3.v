
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos <= ((SegmentWidth+digitXPosition)+(-4))) && 
(ypos <= ((digitYPosition+lineWidth)+(-1))) && 
((xpos >= (digitXPosition+lineWidth)) && 
(ypos >= digitYPosition));
  wire 
       segmentB = (xpos <= (SegmentWidth+(digitXPosition+(-1)))) && 
(ypos <= ((0-(1+1))+(digitYPosition+(SegmentHeight/(1+1))))) && 
(
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))) && (ypos >= digitYPosition));
  wire 
       segmentC = 
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))) && (ypos <= ((SegmentHeight+digitYPosition)-1)) && 
(
(ypos >= ((digitYPosition+(SegmentHeight/(1+1)))+(1+1))) && (xpos <= (SegmentWidth+(digitXPosition+(-1)))));
  wire 
       segmentD = (xpos >= (digitXPosition+lineWidth)) && 
(ypos <= ((SegmentHeight+digitYPosition)-1)) && 
(ypos >= ((SegmentHeight-lineWidth)+digitYPosition)) && (xpos <= ((SegmentWidth+digitXPosition)+(-4)));
  wire 
       segmentE = (ypos <= ((SegmentHeight+digitYPosition)-1)) && 
(
(ypos >= ((digitYPosition+(SegmentHeight/(1+1)))+(1+1))) && 
((xpos >= digitXPosition) && 
(xpos <= ((digitXPosition+lineWidth)+(-1)))));
  wire 
       segmentF = (xpos >= digitXPosition) && 
(xpos <= ((digitXPosition+lineWidth)+(-1))) && 
(
(ypos <= ((0-(1+1))+(digitYPosition+(SegmentHeight/(1+1))))) && (ypos >= digitYPosition));
  wire 
       segmentG = (xpos >= (digitXPosition+lineWidth)) && 
(ypos <= (digitYPosition+((SegmentHeight+lineWidth)*(1/(1+1))))) && 
(
(ypos >= (((SegmentHeight-lineWidth)*(1/(1+1)))+digitYPosition)) && (xpos <= (SegmentWidth+(digitXPosition+(-1)))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (segmentF | ((segmentA | segmentC) | (segmentB | segmentE))) | segmentD;

        1: digitpixel <= segmentC | segmentB;

        1+1: digitpixel <= (segmentA | segmentG) | (segmentE | (segmentD | segmentB));

        3: digitpixel <= (segmentA | segmentC) | ((segmentB | segmentG) | segmentD);

        4: digitpixel <= (segmentC | segmentB) | (segmentF | segmentG);

        5: digitpixel <= (segmentD | segmentF) | ((segmentG | segmentC) | segmentA);

        6: digitpixel <= ((segmentG | segmentC) | segmentA) | ((segmentF | segmentE) | segmentD);

        7: digitpixel <= (segmentC | segmentB) | segmentA;

        8: digitpixel <= ((segmentB | (segmentC | segmentF)) | segmentA) | ((segmentE | segmentD) | segmentG);

        9: digitpixel <= (((segmentA | segmentC) | segmentD) | segmentG) | (segmentB | segmentF);

        10: digitpixel <= ((segmentB | segmentE) | segmentA) | (segmentC | (segmentF | segmentG));

        default: digitpixel <= 0;

      endcase

endmodule

