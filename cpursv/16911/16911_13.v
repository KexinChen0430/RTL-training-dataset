
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos >= digitYPosition) && 
(xpos <= ((digitXPosition+SegmentWidth)+(-4))) && 
((ypos <= ((0-1)+(digitYPosition+lineWidth))) && 
(xpos >= (lineWidth+digitXPosition)));
  wire 
       segmentB = (xpos <= (SegmentWidth+((0-1)+digitXPosition))) && 
(ypos >= digitYPosition) && 
(
(xpos >= (digitXPosition+((-lineWidth)+SegmentWidth))) && 
(ypos <= (digitYPosition+((0-2)+(SegmentHeight/2)))));
  wire 
       segmentC = (ypos <= ((SegmentHeight+(0-1))+digitYPosition)) && 
((xpos <= (SegmentWidth+((0-1)+digitXPosition))) && 
((ypos >= (((SegmentHeight/2)+2)+digitYPosition)) && 
(xpos >= (digitXPosition+((-lineWidth)+SegmentWidth)))));
  wire 
       segmentD = (ypos <= ((SegmentHeight+(0-1))+digitYPosition)) && 
(xpos >= (lineWidth+digitXPosition)) && 
((xpos <= ((digitXPosition+SegmentWidth)+(-4))) && 
(ypos >= ((SegmentHeight+(-lineWidth))+digitYPosition)));
  wire 
       segmentE = (xpos >= digitXPosition) && 
(ypos >= (((SegmentHeight/2)+2)+digitYPosition)) && 
((ypos <= ((SegmentHeight+(0-1))+digitYPosition)) && 
(xpos <= (((0-1)+digitXPosition)+lineWidth)));
  wire 
       segmentF = (ypos >= digitYPosition) && (xpos >= digitXPosition) && 
((xpos <= (((0-1)+digitXPosition)+lineWidth)) && 
(ypos <= (digitYPosition+((0-2)+(SegmentHeight/2)))));
  wire 
       segmentG = 
(ypos <= (((SegmentHeight+lineWidth)*(1/2))+digitYPosition)) && (xpos >= (lineWidth+digitXPosition)) && 
((xpos <= (SegmentWidth+((0-1)+digitXPosition))) && 
(ypos >= (digitYPosition+((SegmentHeight+(-lineWidth))/2))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentC | segmentB) | segmentF) | (segmentE | (segmentD | segmentA));

        1: digitpixel <= segmentC | segmentB;

        2: digitpixel <= (segmentG | segmentA) | ((segmentD | segmentB) | segmentE);

        3: digitpixel <= (segmentD | ((segmentC | segmentB) | segmentG)) | segmentA;

        4: digitpixel <= ((segmentC | segmentB) | segmentG) | segmentF;

        5: digitpixel <= (segmentC | segmentG) | (segmentA | (segmentF | segmentD));

        6: digitpixel <= segmentC | (segmentA | (((segmentD | segmentG) | segmentF) | segmentE));

        7: digitpixel <= segmentA | (segmentC | segmentB);

        8: digitpixel <= (segmentD | (((segmentC | segmentB) | segmentG) | segmentE)) | (segmentF | segmentA);

        9: digitpixel <= (segmentF | (segmentA | segmentB)) | (segmentC | (segmentD | segmentG));

        10: digitpixel <= ((segmentE | segmentF) | (segmentC | segmentB)) | (segmentG | segmentA);

        default: digitpixel <= 0;

      endcase

endmodule

