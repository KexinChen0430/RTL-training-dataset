
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos <= (((0-1)+digitYPosition)+lineWidth)) && 
(xpos <= ((SegmentWidth+digitXPosition)-4)) && 
((xpos >= (digitXPosition+lineWidth)) && 
(ypos >= digitYPosition));
  wire 
       segmentB = 
(ypos <= (digitYPosition+((-2)+((1/2)*SegmentHeight)))) && (xpos <= (digitXPosition+(SegmentWidth+(0-1)))) && 
(
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))) && (ypos >= digitYPosition));
  wire 
       segmentC = (xpos <= (digitXPosition+(SegmentWidth+(0-1)))) && 
(ypos >= (digitYPosition+((1+((1/2)*SegmentHeight))+1))) && (ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition)));
  wire 
       segmentD = (ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(ypos >= ((SegmentHeight+digitYPosition)+(0-lineWidth))) && 
((xpos <= ((SegmentWidth+digitXPosition)-4)) && 
(xpos >= (digitXPosition+lineWidth)));
  wire 
       segmentE = (xpos <= (lineWidth+((0-1)+digitXPosition))) && 
(ypos >= (digitYPosition+((1+((1/2)*SegmentHeight))+1))) && 
((ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(xpos >= digitXPosition));
  wire 
       segmentF = (xpos <= (lineWidth+((0-1)+digitXPosition))) && 
(ypos >= digitYPosition) && 
(
(ypos <= (digitYPosition+((-2)+((1/2)*SegmentHeight)))) && (xpos >= digitXPosition));
  wire 
       segmentG = (xpos >= (digitXPosition+lineWidth)) && 
((xpos <= (digitXPosition+(SegmentWidth+(0-1)))) && 
(
(ypos >= (((SegmentHeight+(0-lineWidth))/2)+digitYPosition)) && 
(ypos <= (((SegmentHeight+lineWidth)/2)+digitYPosition))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentE | segmentC) | segmentF) | ((segmentB | segmentA) | segmentD);

        1: digitpixel <= segmentB | segmentC;

        2: digitpixel <= ((segmentB | segmentA) | segmentD) | (segmentE | segmentG);

        3: digitpixel <= (segmentB | segmentC) | (segmentD | (segmentA | segmentG));

        4: digitpixel <= (segmentG | segmentC) | (segmentB | segmentF);

        5: digitpixel <= ((segmentF | segmentG) | segmentD) | (segmentC | segmentA);

        6: digitpixel <= ((segmentE | segmentC) | segmentF) | (segmentD | (segmentA | segmentG));

        7: digitpixel <= (segmentC | segmentA) | segmentB;

        8: digitpixel <= (((segmentB | segmentF) | (segmentD | segmentG)) | (segmentC | segmentA)) | segmentE;

        9: digitpixel <= ((segmentB | segmentF) | (segmentD | segmentG)) | (segmentC | segmentA);

        10: digitpixel <= (segmentC | segmentA) | ((segmentB | (segmentE | segmentF)) | segmentG);

        default: digitpixel <= 0;

      endcase

endmodule

