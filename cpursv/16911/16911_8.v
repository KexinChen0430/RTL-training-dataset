
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos <= ((-4)+(SegmentWidth+digitXPosition))) && 
(ypos <= (digitYPosition+((0-1)+lineWidth))) && (ypos >= digitYPosition) && 
(xpos >= (lineWidth+digitXPosition));
  wire 
       segmentB = (xpos <= (((0-1)+SegmentWidth)+digitXPosition)) && 
(xpos >= ((SegmentWidth+digitXPosition)+(0-lineWidth))) && 
((ypos >= digitYPosition) && 
(ypos <= (digitYPosition+((-1<<1)+((1/1<<1)*SegmentHeight)))));
  wire 
       segmentC = (xpos <= (((0-1)+SegmentWidth)+digitXPosition)) && 
(
(ypos >= ((1<<1+((1/1<<1)*SegmentHeight))+digitYPosition)) && (ypos <= ((0-1)+(SegmentHeight+digitYPosition)))) && 
(xpos >= ((SegmentWidth+digitXPosition)+(0-lineWidth)));
  wire 
       segmentD = 
(ypos >= ((SegmentHeight-lineWidth)+digitYPosition)) && (ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
((xpos >= (lineWidth+digitXPosition)) && 
(xpos <= ((-4)+(SegmentWidth+digitXPosition))));
  wire 
       segmentE = (xpos >= digitXPosition) && 
(xpos <= ((lineWidth+digitXPosition)+(0-1))) && 
(
(ypos >= ((1<<1+((1/1<<1)*SegmentHeight))+digitYPosition)) && (ypos <= ((0-1)+(SegmentHeight+digitYPosition))));
  wire 
       segmentF = (xpos >= digitXPosition) && 
(ypos <= (digitYPosition+((-1<<1)+((1/1<<1)*SegmentHeight)))) && 
((xpos <= ((lineWidth+digitXPosition)+(0-1))) && 
(ypos >= digitYPosition));
  wire 
       segmentG = 
(ypos <= (digitYPosition+((lineWidth+SegmentHeight)/1<<1))) && 
(ypos >= (digitYPosition+((1/1<<1)*(SegmentHeight-lineWidth)))) && 
((xpos >= (lineWidth+digitXPosition)) && 
(xpos <= (((0-1)+SegmentWidth)+digitXPosition)));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (((segmentB | segmentA) | segmentF) | segmentC) | (segmentD | segmentE);

        1: digitpixel <= segmentC | segmentB;

        1<<1: digitpixel <= segmentD | ((segmentE | (segmentG | segmentA)) | segmentB);

        3: digitpixel <= (segmentD | segmentB) | ((segmentC | segmentA) | segmentG);

        4: digitpixel <= segmentF | (segmentG | (segmentC | segmentB));

        5: digitpixel <= ((segmentC | segmentD) | segmentF) | (segmentG | segmentA);

        6: digitpixel <= ((segmentF | segmentA) | (segmentG | segmentC)) | (segmentD | segmentE);

        7: digitpixel <= segmentA | (segmentC | segmentB);

        8: digitpixel <= ((segmentC | segmentB) | segmentD) | ((segmentF | segmentE) | (segmentG | segmentA));

        9: digitpixel <= (segmentB | segmentA) | ((segmentF | segmentG) | (segmentC | segmentD));

        10: digitpixel <= (segmentF | segmentE) | ((segmentG | segmentA) | (segmentC | segmentB));

        default: digitpixel <= 0;

      endcase

endmodule

