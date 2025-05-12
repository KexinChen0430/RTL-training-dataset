
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos <= ((digitXPosition+SegmentWidth)-4)) && 
(ypos >= digitYPosition) && (ypos <= (digitYPosition+(lineWidth+(-1)))) && 
(xpos >= (digitXPosition+lineWidth));
  wire 
       segmentB = (ypos >= digitYPosition) && 
((xpos <= (digitXPosition+(SegmentWidth+(-1)))) && 
(
(xpos >= ((SegmentWidth+(0-lineWidth))+digitXPosition)) && 
(ypos <= ((0-2)+((SegmentHeight/2)+digitYPosition)))));
  wire 
       segmentC = 
(xpos >= ((SegmentWidth+(0-lineWidth))+digitXPosition)) && (ypos <= ((SegmentHeight+digitYPosition)-1)) && 
((ypos >= (digitYPosition+(2+(SegmentHeight/2)))) && 
(xpos <= (digitXPosition+(SegmentWidth+(-1)))));
  wire 
       segmentD = 
(ypos >= ((SegmentHeight+digitYPosition)+(0-lineWidth))) && 
((xpos <= ((digitXPosition+SegmentWidth)-4)) && 
(xpos >= (digitXPosition+lineWidth)) && (ypos <= ((SegmentHeight+digitYPosition)-1)));
  wire 
       segmentE = (ypos >= (digitYPosition+(2+(SegmentHeight/2)))) && 
(ypos <= ((SegmentHeight+digitYPosition)-1)) && 
((xpos >= digitXPosition) && 
(xpos <= (lineWidth+((-1)+digitXPosition))));
  wire 
       segmentF = (xpos >= digitXPosition) && 
(xpos <= (lineWidth+((-1)+digitXPosition))) && 
(ypos <= ((0-2)+((SegmentHeight/2)+digitYPosition))) && (ypos >= digitYPosition);
  wire 
       segmentG = 
(ypos >= (digitYPosition+((SegmentHeight+(0-lineWidth))*(1/2)))) && 
(
(ypos <= (((lineWidth+SegmentHeight)*(1/2))+digitYPosition)) && (xpos >= (digitXPosition+lineWidth)) && 
(xpos <= (digitXPosition+(SegmentWidth+(-1)))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (segmentE | (segmentA | segmentB)) | (segmentF | (segmentC | segmentD));

        1: digitpixel <= segmentB | segmentC;

        2: digitpixel <= ((segmentB | segmentG) | segmentA) | (segmentE | segmentD);

        3: digitpixel <= ((segmentB | segmentC) | (segmentG | segmentA)) | segmentD;

        4: digitpixel <= (segmentG | segmentF) | (segmentB | segmentC);

        5: digitpixel <= (segmentF | (segmentC | segmentD)) | (segmentG | segmentA);

        6: digitpixel <= (segmentE | segmentG) | ((segmentC | segmentF) | (segmentD | segmentA));

        7: digitpixel <= (segmentB | segmentC) | segmentA;

        8: digitpixel <= (((segmentE | segmentA) | (segmentG | segmentF)) | (segmentB | segmentC)) | segmentD;

        9: digitpixel <= (segmentD | segmentF) | ((segmentB | segmentC) | (segmentG | segmentA));

        10: digitpixel <= ((segmentE | segmentA) | (segmentG | segmentF)) | (segmentB | segmentC);

        default: digitpixel <= 0;

      endcase

endmodule

