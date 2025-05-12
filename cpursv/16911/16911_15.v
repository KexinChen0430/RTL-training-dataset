
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos >= digitYPosition) && 
((xpos <= (((0-4)+digitXPosition)+SegmentWidth)) && 
(xpos >= (lineWidth+digitXPosition))) && (ypos <= ((lineWidth+digitYPosition)-1));
  wire 
       segmentB = 
(ypos <= (((SegmentHeight/(1+1))+digitYPosition)-(1+1))) && 
(xpos >= ((SegmentWidth+digitXPosition)+(-lineWidth))) && 
((ypos >= digitYPosition) && 
(xpos <= ((SegmentWidth+digitXPosition)-1)));
  wire 
       segmentC = (xpos <= ((SegmentWidth+digitXPosition)-1)) && 
(xpos >= ((SegmentWidth+digitXPosition)+(-lineWidth))) && 
((ypos <= ((SegmentHeight+digitYPosition)-1)) && 
(ypos >= ((1+1)+((SegmentHeight/(1+1))+digitYPosition))));
  wire 
       segmentD = 
(ypos >= (digitYPosition+(SegmentHeight-lineWidth))) && 
((xpos <= (((0-4)+digitXPosition)+SegmentWidth)) && 
(ypos <= ((SegmentHeight+digitYPosition)-1))) && (xpos >= (lineWidth+digitXPosition));
  wire 
       segmentE = (xpos >= digitXPosition) && 
(xpos <= ((digitXPosition+(-1))+lineWidth)) && 
((ypos <= ((SegmentHeight+digitYPosition)-1)) && 
(ypos >= ((1+1)+((SegmentHeight/(1+1))+digitYPosition))));
  wire 
       segmentF = (ypos >= digitYPosition) && (xpos >= digitXPosition) && 
(xpos <= ((digitXPosition+(-1))+lineWidth)) && 
(ypos <= (((SegmentHeight/(1+1))+digitYPosition)-(1+1)));
  wire 
       segmentG = 
(ypos >= (((1/(1+1))*(SegmentHeight-lineWidth))+digitYPosition)) && 
((xpos <= ((SegmentWidth+digitXPosition)-1)) && 
(xpos >= (lineWidth+digitXPosition))) && 
(ypos <= (((SegmentHeight+lineWidth)/(1+1))+digitYPosition));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentD | segmentA) | segmentB) | (segmentE | (segmentF | segmentC));

        1: digitpixel <= segmentC | segmentB;

        1+1: digitpixel <= segmentD | ((segmentA | segmentE) | (segmentG | segmentB));

        3: digitpixel <= ((segmentC | segmentA) | segmentB) | (segmentD | segmentG);

        4: digitpixel <= (segmentC | segmentB) | (segmentG | segmentF);

        5: digitpixel <= (segmentC | (segmentF | segmentA)) | (segmentD | segmentG);

        6: digitpixel <= segmentE | ((segmentC | (segmentF | segmentA)) | (segmentD | segmentG));

        7: digitpixel <= (segmentC | segmentA) | segmentB;

        8: digitpixel <= (segmentD | segmentB) | ((segmentC | (segmentF | (segmentA | segmentG))) | segmentE);

        9: digitpixel <= ((segmentA | segmentG) | ((segmentC | segmentB) | segmentF)) | segmentD;

        10: digitpixel <= ((segmentC | segmentB) | segmentF) | (segmentG | (segmentA | segmentE));

        default: digitpixel <= 0;

      endcase

endmodule

