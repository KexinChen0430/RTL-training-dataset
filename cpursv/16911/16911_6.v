
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos >= digitYPosition) && 
(ypos <= (((-1)+digitYPosition)+lineWidth)) && 
((xpos >= (digitXPosition+lineWidth)) && 
(xpos <= (SegmentWidth+(digitXPosition+(0-4)))));
  wire 
       segmentB = 
(xpos >= ((digitXPosition+SegmentWidth)+(0-lineWidth))) && 
(
(ypos <= ((0-1<<<1)+(((1/1<<<1)*SegmentHeight)+digitYPosition))) && (ypos >= digitYPosition) && 
(xpos <= (((-1)+digitXPosition)+SegmentWidth)));
  wire 
       segmentC = 
(ypos >= (digitYPosition+(1<<<1+((1/1<<<1)*SegmentHeight)))) && 
(
(xpos >= ((digitXPosition+SegmentWidth)+(0-lineWidth))) && 
((ypos <= ((SegmentHeight+digitYPosition)+(-1))) && 
(xpos <= (((-1)+digitXPosition)+SegmentWidth))));
  wire 
       segmentD = 
(ypos >= (SegmentHeight+(digitYPosition+(0-lineWidth)))) && 
((ypos <= ((SegmentHeight+digitYPosition)+(-1))) && 
(xpos <= (SegmentWidth+(digitXPosition+(0-4)))) && (xpos >= (digitXPosition+lineWidth)));
  wire 
       segmentE = (xpos <= (((-1)+digitXPosition)+lineWidth)) && 
(
(ypos >= (digitYPosition+(1<<<1+((1/1<<<1)*SegmentHeight)))) && (ypos <= ((SegmentHeight+digitYPosition)+(-1)))) && (xpos >= digitXPosition);
  wire 
       segmentF = (xpos >= digitXPosition) && 
((xpos <= (((-1)+digitXPosition)+lineWidth)) && 
(
(ypos <= ((0-1<<<1)+(((1/1<<<1)*SegmentHeight)+digitYPosition))) && (ypos >= digitYPosition)));
  wire 
       segmentG = (xpos <= (((-1)+digitXPosition)+SegmentWidth)) && 
(
(ypos <= (digitYPosition+((lineWidth+SegmentHeight)/1<<<1))) && 
(
(ypos >= (digitYPosition+((1/1<<<1)*((0-lineWidth)+SegmentHeight)))) && (xpos >= (digitXPosition+lineWidth))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (((segmentD | segmentB) | segmentE) | segmentF) | (segmentA | segmentC);

        1: digitpixel <= segmentC | segmentB;

        1<<<1: digitpixel <= ((segmentG | segmentE) | segmentD) | (segmentB | segmentA);

        3: digitpixel <= ((segmentC | segmentB) | segmentD) | (segmentG | segmentA);

        4: digitpixel <= ((segmentB | segmentF) | segmentG) | segmentC;

        5: digitpixel <= (segmentG | (segmentF | segmentA)) | (segmentD | segmentC);

        6: digitpixel <= (segmentC | segmentE) | (segmentD | (segmentG | (segmentF | segmentA)));

        7: digitpixel <= segmentC | (segmentB | segmentA);

        8: digitpixel <= ((segmentC | segmentG) | segmentE) | ((segmentB | segmentA) | (segmentF | segmentD));

        9: digitpixel <= (segmentC | segmentF) | (((segmentG | segmentD) | segmentB) | segmentA);

        10: digitpixel <= (segmentC | segmentG) | ((segmentE | segmentA) | (segmentB | segmentF));

        default: digitpixel <= 0;

      endcase

endmodule

