
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos <= ((digitYPosition+lineWidth)-1)) && 
(ypos >= digitYPosition) && 
((xpos >= (lineWidth+digitXPosition)) && 
(xpos <= ((0-4)+(SegmentWidth+digitXPosition))));
  wire 
       segmentB = (xpos <= ((SegmentWidth+digitXPosition)-1)) && 
(ypos >= digitYPosition) && 
(
(ypos <= (((-1<<1)+digitYPosition)+((1/1<<1)*SegmentHeight))) && 
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))));
  wire 
       segmentC = (xpos <= ((SegmentWidth+digitXPosition)-1)) && 
(ypos >= (1<<1+(((1/1<<1)*SegmentHeight)+digitYPosition))) && 
((ypos <= (digitYPosition+((-1)+SegmentHeight))) && 
(xpos >= ((0-lineWidth)+(SegmentWidth+digitXPosition))));
  wire 
       segmentD = (xpos >= (lineWidth+digitXPosition)) && 
(ypos >= (digitYPosition+((0-lineWidth)+SegmentHeight))) && (ypos <= (digitYPosition+((-1)+SegmentHeight))) && 
(xpos <= ((0-4)+(SegmentWidth+digitXPosition)));
  wire 
       segmentE = (xpos <= ((lineWidth+digitXPosition)+(-1))) && 
(ypos >= (1<<1+(((1/1<<1)*SegmentHeight)+digitYPosition))) && 
((ypos <= (digitYPosition+((-1)+SegmentHeight))) && 
(xpos >= digitXPosition));
  wire 
       segmentF = (xpos <= ((lineWidth+digitXPosition)+(-1))) && 
((ypos >= digitYPosition) && (xpos >= digitXPosition)) && 
(ypos <= (((-1<<1)+digitYPosition)+((1/1<<1)*SegmentHeight)));
  wire 
       segmentG = (xpos >= (lineWidth+digitXPosition)) && 
(
(ypos >= (digitYPosition+(((0-lineWidth)+SegmentHeight)/1<<1))) && (xpos <= ((SegmentWidth+digitXPosition)-1)) && 
(ypos <= (((lineWidth+SegmentHeight)*(1/1<<1))+digitYPosition)));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentE | segmentD) | segmentF) | ((segmentC | segmentA) | segmentB);

        1: digitpixel <= segmentB | segmentC;

        1<<1: digitpixel <= (segmentD | segmentA) | ((segmentB | segmentE) | segmentG);

        3: digitpixel <= (segmentG | (segmentB | segmentC)) | (segmentD | segmentA);

        4: digitpixel <= (segmentG | segmentC) | (segmentF | segmentB);

        5: digitpixel <= (segmentC | segmentD) | ((segmentA | segmentG) | segmentF);

        6: digitpixel <= ((segmentF | segmentE) | (segmentD | (segmentC | segmentA))) | segmentG;

        7: digitpixel <= (segmentC | segmentA) | segmentB;

        8: digitpixel <= (segmentG | segmentE) | (((segmentD | segmentF) | segmentB) | (segmentC | segmentA));

        9: digitpixel <= (segmentB | ((segmentG | segmentC) | segmentA)) | (segmentD | segmentF);

        10: digitpixel <= (segmentF | segmentG) | (segmentB | ((segmentC | segmentA) | segmentE));

        default: digitpixel <= 0;

      endcase

endmodule

