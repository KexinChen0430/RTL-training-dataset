
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos <= (SegmentWidth+((-4)+digitXPosition))) && 
(ypos >= digitYPosition) && 
((ypos <= ((digitYPosition+lineWidth)+(-1))) && 
(xpos >= (digitXPosition+lineWidth)));
  wire 
       segmentB = (ypos >= digitYPosition) && 
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))) && (xpos <= (SegmentWidth+((-1)+digitXPosition))) && 
(ypos <= (((SegmentHeight/(1+1))+digitYPosition)+(-(1+1))));
  wire 
       segmentC = 
(ypos >= (1+(((SegmentHeight/(1+1))+digitYPosition)+1))) && (ypos <= (SegmentHeight+((-1)+digitYPosition))) && 
(
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))) && (xpos <= (SegmentWidth+((-1)+digitXPosition))));
  wire 
       segmentD = (xpos <= (SegmentWidth+((-4)+digitXPosition))) && 
(ypos <= (SegmentHeight+((-1)+digitYPosition))) && 
(
(ypos >= (digitYPosition+(SegmentHeight-lineWidth))) && (xpos >= (digitXPosition+lineWidth)));
  wire 
       segmentE = (ypos <= (SegmentHeight+((-1)+digitYPosition))) && 
((xpos >= digitXPosition) && 
(xpos <= (lineWidth+((-1)+digitXPosition))) && 
(ypos >= (1+(((SegmentHeight/(1+1))+digitYPosition)+1))));
  wire 
       segmentF = (ypos >= digitYPosition) && 
((xpos <= (lineWidth+((-1)+digitXPosition))) && 
(ypos <= (((SegmentHeight/(1+1))+digitYPosition)+(-(1+1))))) && (xpos >= digitXPosition);
  wire 
       segmentG = 
(ypos <= (digitYPosition+((SegmentHeight+lineWidth)/(1+1)))) && (xpos >= (digitXPosition+lineWidth)) && 
(xpos <= (SegmentWidth+((-1)+digitXPosition))) && 
(ypos >= (((SegmentHeight-lineWidth)/(1+1))+digitYPosition));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (segmentE | (segmentA | segmentF)) | (segmentC | (segmentB | segmentD));

        1: digitpixel <= segmentC | segmentB;

        1+1: digitpixel <= (segmentB | segmentE) | ((segmentA | segmentD) | segmentG);

        3: digitpixel <= (segmentC | segmentD) | ((segmentA | segmentG) | segmentB);

        4: digitpixel <= ((segmentB | segmentG) | segmentC) | segmentF;

        5: digitpixel <= ((segmentG | segmentF) | segmentD) | (segmentC | segmentA);

        6: digitpixel <= (segmentC | segmentD) | (segmentG | (segmentE | (segmentA | segmentF)));

        7: digitpixel <= (segmentC | segmentA) | segmentB;

        8: digitpixel <= ((segmentB | segmentD) | segmentF) | (segmentC | ((segmentA | segmentG) | segmentE));

        9: digitpixel <= (segmentB | (segmentC | segmentF)) | ((segmentA | segmentD) | segmentG);

        10: digitpixel <= (segmentB | (segmentE | segmentG)) | ((segmentC | segmentF) | segmentA);

        default: digitpixel <= 0;

      endcase

endmodule

