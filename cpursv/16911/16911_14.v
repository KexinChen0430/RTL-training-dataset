
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos <= ((SegmentWidth+digitXPosition)+(0-4))) && 
(ypos <= ((lineWidth+digitYPosition)+(0-1))) && 
((xpos >= (digitXPosition+lineWidth)) && 
(ypos >= digitYPosition));
  wire 
       segmentB = (ypos >= digitYPosition) && 
(xpos >= ((-lineWidth)+(SegmentWidth+digitXPosition))) && 
((xpos <= ((0-1)+(SegmentWidth+digitXPosition))) && 
(ypos <= ((digitYPosition+(0-2))+((1/2)*SegmentHeight))));
  wire 
       segmentC = (ypos <= ((digitYPosition+(0-1))+SegmentHeight)) && 
(xpos <= ((0-1)+(SegmentWidth+digitXPosition))) && 
(
(xpos >= ((-lineWidth)+(SegmentWidth+digitXPosition))) && 
(ypos >= ((2+((1/2)*SegmentHeight))+digitYPosition)));
  wire 
       segmentD = (xpos <= ((SegmentWidth+digitXPosition)+(0-4))) && 
(ypos <= ((digitYPosition+(0-1))+SegmentHeight)) && (xpos >= (digitXPosition+lineWidth)) && 
(ypos >= (((-lineWidth)+SegmentHeight)+digitYPosition));
  wire 
       segmentE = (xpos <= (lineWidth+((0-1)+digitXPosition))) && 
(ypos <= ((digitYPosition+(0-1))+SegmentHeight)) && 
(
(ypos >= ((2+((1/2)*SegmentHeight))+digitYPosition)) && (xpos >= digitXPosition));
  wire 
       segmentF = (ypos >= digitYPosition) && 
((xpos <= (lineWidth+((0-1)+digitXPosition))) && 
(ypos <= ((digitYPosition+(0-2))+((1/2)*SegmentHeight)))) && (xpos >= digitXPosition);
  wire 
       segmentG = (xpos <= ((0-1)+(SegmentWidth+digitXPosition))) && 
(xpos >= (digitXPosition+lineWidth)) && 
(
(ypos <= (((lineWidth+SegmentHeight)*(1/2))+digitYPosition)) && 
(ypos >= (((1/2)*((-lineWidth)+SegmentHeight))+digitYPosition)));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentD | segmentF) | segmentE) | (segmentB | (segmentC | segmentA));

        1: digitpixel <= segmentB | segmentC;

        2: digitpixel <= segmentE | (segmentA | (segmentD | (segmentG | segmentB)));

        3: digitpixel <= segmentB | (segmentD | ((segmentC | segmentA) | segmentG));

        4: digitpixel <= (segmentF | (segmentC | segmentG)) | segmentB;

        5: digitpixel <= ((segmentF | segmentG) | segmentA) | (segmentD | segmentC);

        6: digitpixel <= ((segmentG | segmentD) | (segmentE | segmentC)) | (segmentF | segmentA);

        7: digitpixel <= segmentB | (segmentC | segmentA);

        8: digitpixel <= ((segmentD | segmentA) | (segmentC | (segmentB | segmentE))) | (segmentF | segmentG);

        9: digitpixel <= (segmentF | (segmentC | segmentA)) | (segmentD | (segmentG | segmentB));

        10: digitpixel <= ((segmentB | segmentC) | (segmentA | segmentG)) | (segmentF | segmentE);

        default: digitpixel <= 0;

      endcase

endmodule

