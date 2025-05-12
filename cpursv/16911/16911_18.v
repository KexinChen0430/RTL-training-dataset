
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos <= ((digitXPosition+SegmentWidth)+(0-4))) && 
(ypos >= digitYPosition) && 
((ypos <= (lineWidth+(digitYPosition+(0-1)))) && 
(xpos >= (digitXPosition+lineWidth)));
  wire 
       segmentB = (ypos >= digitYPosition) && 
(xpos >= (digitXPosition+(SegmentWidth+(-lineWidth)))) && 
(
(ypos <= (((SegmentHeight/2)+digitYPosition)+(-2))) && (xpos <= (((0-1)+digitXPosition)+SegmentWidth)));
  wire 
       segmentC = (xpos <= (((0-1)+digitXPosition)+SegmentWidth)) && 
(xpos >= (digitXPosition+(SegmentWidth+(-lineWidth)))) && 
((ypos <= ((SegmentHeight+digitYPosition)+(0-1))) && 
(ypos >= ((SegmentHeight/2)+(digitYPosition+2))));
  wire 
       segmentD = (xpos >= (digitXPosition+lineWidth)) && 
(ypos <= ((SegmentHeight+digitYPosition)+(0-1))) && 
((xpos <= ((digitXPosition+SegmentWidth)+(0-4))) && 
(ypos >= ((SegmentHeight-lineWidth)+digitYPosition)));
  wire 
       segmentE = (ypos <= ((SegmentHeight+digitYPosition)+(0-1))) && 
(xpos <= ((0-1)+(digitXPosition+lineWidth))) && 
((ypos >= ((SegmentHeight/2)+(digitYPosition+2))) && 
(xpos >= digitXPosition));
  wire 
       segmentF = (ypos >= digitYPosition) && 
(xpos <= ((0-1)+(digitXPosition+lineWidth))) && 
((xpos >= digitXPosition) && 
(ypos <= (((SegmentHeight/2)+digitYPosition)+(-2))));
  wire 
       segmentG = (xpos >= (digitXPosition+lineWidth)) && 
((xpos <= (((0-1)+digitXPosition)+SegmentWidth)) && 
(ypos >= (((SegmentHeight-lineWidth)*(1/2))+digitYPosition)) && 
(ypos <= (((SegmentHeight+lineWidth)*(1/2))+digitYPosition)));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (segmentC | (segmentE | (segmentF | segmentD))) | (segmentA | segmentB);

        1: digitpixel <= segmentB | segmentC;

        2: digitpixel <= (segmentE | segmentG) | (segmentA | (segmentB | segmentD));

        3: digitpixel <= ((segmentA | segmentC) | (segmentD | segmentG)) | segmentB;

        4: digitpixel <= (segmentB | segmentF) | (segmentC | segmentG);

        5: digitpixel <= ((segmentA | segmentF) | segmentD) | (segmentC | segmentG);

        6: digitpixel <= (segmentE | segmentF) | ((segmentA | segmentC) | (segmentD | segmentG));

        7: digitpixel <= (segmentA | segmentC) | segmentB;

        8: digitpixel <= (segmentB | (segmentF | segmentG)) | ((segmentA | segmentD) | (segmentC | segmentE));

        9: digitpixel <= ((segmentA | segmentF) | segmentD) | (segmentB | (segmentC | segmentG));

        10: digitpixel <= segmentB | (((segmentA | segmentG) | segmentE) | (segmentC | segmentF));

        default: digitpixel <= 0;

      endcase

endmodule

