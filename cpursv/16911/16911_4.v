
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos <= ((digitYPosition+(0-1))+lineWidth)) && 
((ypos >= digitYPosition) && 
(xpos >= (lineWidth+digitXPosition))) && (xpos <= ((digitXPosition+SegmentWidth)-4));
  wire 
       segmentB = (ypos >= digitYPosition) && 
(
(xpos >= ((digitXPosition+SegmentWidth)+(0-lineWidth))) && 
(ypos <= (digitYPosition+(((1/2)*SegmentHeight)+(-2)))) && (xpos <= (SegmentWidth+(digitXPosition+(0-1)))));
  wire 
       segmentC = 
(xpos >= ((digitXPosition+SegmentWidth)+(0-lineWidth))) && 
((ypos <= ((digitYPosition+SegmentHeight)+(0-1))) && 
(ypos >= ((1+(1+digitYPosition))+((1/2)*SegmentHeight))) && (xpos <= (SegmentWidth+(digitXPosition+(0-1)))));
  wire 
       segmentD = 
(ypos >= ((digitYPosition+SegmentHeight)+(0-lineWidth))) && 
((xpos >= (lineWidth+digitXPosition)) && 
((xpos <= ((digitXPosition+SegmentWidth)-4)) && 
(ypos <= ((digitYPosition+SegmentHeight)+(0-1)))));
  wire 
       segmentE = (ypos <= ((digitYPosition+SegmentHeight)+(0-1))) && 
(xpos >= digitXPosition) && 
(
(ypos >= ((1+(1+digitYPosition))+((1/2)*SegmentHeight))) && (xpos <= (((0-1)+lineWidth)+digitXPosition)));
  wire 
       segmentF = (xpos >= digitXPosition) && 
(xpos <= (((0-1)+lineWidth)+digitXPosition)) && 
((ypos >= digitYPosition) && 
(ypos <= (digitYPosition+(((1/2)*SegmentHeight)+(-2)))));
  wire 
       segmentG = (xpos >= (lineWidth+digitXPosition)) && 
(ypos >= ((((0-lineWidth)+SegmentHeight)/2)+digitYPosition)) && 
((xpos <= (SegmentWidth+(digitXPosition+(0-1)))) && 
(ypos <= (((1/2)*(SegmentHeight+lineWidth))+digitYPosition)));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentE | segmentD) | (segmentF | segmentB)) | (segmentC | segmentA);

        1: digitpixel <= segmentC | segmentB;

        2: digitpixel <= (segmentG | segmentB) | (segmentA | (segmentE | segmentD));

        3: digitpixel <= (segmentA | segmentG) | ((segmentB | segmentD) | segmentC);

        4: digitpixel <= (segmentB | (segmentG | segmentC)) | segmentF;

        5: digitpixel <= (segmentD | (segmentG | segmentC)) | (segmentF | segmentA);

        6: digitpixel <= (segmentF | (segmentA | segmentE)) | (segmentD | (segmentG | segmentC));

        7: digitpixel <= (segmentB | segmentA) | segmentC;

        8: digitpixel <= ((segmentB | segmentD) | segmentE) | ((segmentC | segmentA) | (segmentG | segmentF));

        9: digitpixel <= (segmentD | (segmentF | segmentB)) | ((segmentC | segmentA) | segmentG);

        10: digitpixel <= (segmentB | (segmentG | segmentC)) | (segmentF | (segmentA | segmentE));

        default: digitpixel <= 0;

      endcase

endmodule

