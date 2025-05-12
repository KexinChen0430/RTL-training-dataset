
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos <= (((-1)+digitYPosition)+lineWidth)) && 
(ypos >= digitYPosition) && 
((xpos >= (lineWidth+digitXPosition)) && 
(xpos <= ((0-4)+(SegmentWidth+digitXPosition))));
  wire 
       segmentB = 
(ypos <= ((digitYPosition+(SegmentHeight/(1+1)))-(1+1))) && (xpos <= ((-1)+(SegmentWidth+digitXPosition))) && 
(xpos >= ((SegmentWidth+digitXPosition)+(0-lineWidth))) && (ypos >= digitYPosition);
  wire 
       segmentC = 
(xpos >= ((SegmentWidth+digitXPosition)+(0-lineWidth))) && (ypos <= (((-1)+digitYPosition)+SegmentHeight)) && 
((xpos <= ((-1)+(SegmentWidth+digitXPosition))) && 
(ypos >= (1+(1+(digitYPosition+(SegmentHeight/(1+1)))))));
  wire 
       segmentD = 
(ypos >= (digitYPosition+(SegmentHeight-lineWidth))) && (ypos <= (((-1)+digitYPosition)+SegmentHeight)) && 
((xpos >= (lineWidth+digitXPosition)) && 
(xpos <= ((0-4)+(SegmentWidth+digitXPosition))));
  wire 
       segmentE = 
(ypos >= (1+(1+(digitYPosition+(SegmentHeight/(1+1)))))) && (xpos <= ((-1)+(lineWidth+digitXPosition))) && 
((xpos >= digitXPosition) && 
(ypos <= (((-1)+digitYPosition)+SegmentHeight)));
  wire 
       segmentF = (xpos >= digitXPosition) && 
(ypos <= ((digitYPosition+(SegmentHeight/(1+1)))-(1+1))) && 
((xpos <= ((-1)+(lineWidth+digitXPosition))) && 
(ypos >= digitYPosition));
  wire 
       segmentG = 
(ypos <= (((1/(1+1))*(lineWidth+SegmentHeight))+digitYPosition)) && 
((xpos <= ((-1)+(SegmentWidth+digitXPosition))) && 
(ypos >= (((1/(1+1))*(SegmentHeight-lineWidth))+digitYPosition))) && (xpos >= (lineWidth+digitXPosition));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentB | segmentA) | segmentC) | ((segmentD | segmentF) | segmentE);

        1: digitpixel <= segmentB | segmentC;

        1+1: digitpixel <= ((segmentB | segmentG) | segmentE) | (segmentD | segmentA);

        3: digitpixel <= (segmentG | ((segmentB | segmentA) | segmentC)) | segmentD;

        4: digitpixel <= segmentC | (segmentF | (segmentB | segmentG));

        5: digitpixel <= (segmentF | segmentG) | (segmentD | (segmentA | segmentC));

        6: digitpixel <= (segmentA | (segmentF | segmentG)) | (segmentE | (segmentC | segmentD));

        7: digitpixel <= (segmentB | segmentA) | segmentC;

        8: digitpixel <= (segmentG | ((segmentB | segmentA) | segmentC)) | ((segmentD | segmentF) | segmentE);

        9: digitpixel <= ((segmentD | segmentG) | segmentA) | (segmentC | (segmentF | segmentB));

        10: digitpixel <= ((segmentB | segmentG) | segmentA) | ((segmentF | segmentC) | segmentE);

        default: digitpixel <= 0;

      endcase

endmodule

