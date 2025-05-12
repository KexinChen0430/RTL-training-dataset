
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos >= digitYPosition) && 
((xpos >= (digitXPosition+lineWidth)) && 
((ypos <= (lineWidth+(digitYPosition+(0-1)))) && 
(xpos <= ((SegmentWidth+digitXPosition)+(-4)))));
  wire 
       segmentB = 
(ypos <= (((0-2)+digitYPosition)+((1/2)*SegmentHeight))) && 
(
(xpos >= ((SegmentWidth+(-lineWidth))+digitXPosition)) && (ypos >= digitYPosition) && 
(xpos <= ((SegmentWidth+digitXPosition)+(0-1))));
  wire 
       segmentC = (xpos <= ((SegmentWidth+digitXPosition)+(0-1))) && 
(ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(
(xpos >= ((SegmentWidth+(-lineWidth))+digitXPosition)) && 
(ypos >= (((digitYPosition+((1/2)*SegmentHeight))+1)+1)));
  wire 
       segmentD = 
(ypos >= ((SegmentHeight+digitYPosition)-lineWidth)) && 
((xpos <= ((SegmentWidth+digitXPosition)+(-4))) && 
((ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(xpos >= (digitXPosition+lineWidth))));
  wire 
       segmentE = (ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
((xpos <= ((lineWidth+(0-1))+digitXPosition)) && 
((xpos >= digitXPosition) && 
(ypos >= (((digitYPosition+((1/2)*SegmentHeight))+1)+1))));
  wire 
       segmentF = (xpos >= digitXPosition) && 
((xpos <= ((lineWidth+(0-1))+digitXPosition)) && 
(ypos <= (((0-2)+digitYPosition)+((1/2)*SegmentHeight))) && (ypos >= digitYPosition));
  wire 
       segmentG = (xpos >= (digitXPosition+lineWidth)) && 
(ypos >= (digitYPosition+((1/2)*((-lineWidth)+SegmentHeight)))) && 
(
(ypos <= (digitYPosition+((SegmentHeight+lineWidth)*(1/2)))) && (xpos <= ((SegmentWidth+digitXPosition)+(0-1))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentA | segmentE) | (segmentC | segmentB)) | (segmentF | segmentD);

        1: digitpixel <= segmentC | segmentB;

        2: digitpixel <= segmentE | (((segmentG | segmentD) | segmentA) | segmentB);

        3: digitpixel <= ((segmentC | segmentA) | (segmentG | segmentB)) | segmentD;

        4: digitpixel <= (segmentC | segmentB) | (segmentG | segmentF);

        5: digitpixel <= (segmentF | segmentC) | ((segmentG | segmentD) | segmentA);

        6: digitpixel <= ((segmentE | (segmentG | segmentC)) | segmentA) | (segmentF | segmentD);

        7: digitpixel <= (segmentC | segmentB) | segmentA;

        8: digitpixel <= (segmentE | segmentC) | ((segmentA | (segmentB | segmentF)) | (segmentG | segmentD));

        9: digitpixel <= (segmentA | (segmentB | segmentF)) | (segmentD | (segmentG | segmentC));

        10: digitpixel <= ((segmentA | segmentE) | (segmentC | segmentB)) | (segmentG | segmentF);

        default: digitpixel <= 0;

      endcase

endmodule

