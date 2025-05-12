
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos >= (digitXPosition+lineWidth)) && 
(xpos <= ((0-4)+(digitXPosition+SegmentWidth))) && 
((ypos <= (((-1)+digitYPosition)+lineWidth)) && 
(ypos >= digitYPosition));
  wire 
       segmentB = (xpos <= ((SegmentWidth+(-1))+digitXPosition)) && 
(xpos >= ((digitXPosition+SegmentWidth)-lineWidth)) && 
(
(ypos <= (((0-2)+(SegmentHeight/2))+digitYPosition)) && (ypos >= digitYPosition));
  wire 
       segmentC = 
(xpos >= ((digitXPosition+SegmentWidth)-lineWidth)) && (ypos >= (digitYPosition+((SegmentHeight/2)+2))) && 
((xpos <= ((SegmentWidth+(-1))+digitXPosition)) && 
(ypos <= ((digitYPosition+SegmentHeight)+(-1))));
  wire 
       segmentD = (ypos <= ((digitYPosition+SegmentHeight)+(-1))) && 
(xpos >= (digitXPosition+lineWidth)) && 
(
(ypos >= ((0-lineWidth)+(digitYPosition+SegmentHeight))) && (xpos <= ((0-4)+(digitXPosition+SegmentWidth))));
  wire 
       segmentE = (xpos >= digitXPosition) && 
((ypos >= (digitYPosition+((SegmentHeight/2)+2))) && 
(ypos <= ((digitYPosition+SegmentHeight)+(-1)))) && (xpos <= ((digitXPosition+lineWidth)-1));
  wire 
       segmentF = (xpos <= ((digitXPosition+lineWidth)-1)) && 
(ypos >= digitYPosition) && 
(
(ypos <= (((0-2)+(SegmentHeight/2))+digitYPosition)) && (xpos >= digitXPosition));
  wire 
       segmentG = (xpos <= ((SegmentWidth+(-1))+digitXPosition)) && 
(ypos <= (((lineWidth+SegmentHeight)*(1/2))+digitYPosition)) && 
((xpos >= (digitXPosition+lineWidth)) && 
(ypos >= (((SegmentHeight-lineWidth)*(1/2))+digitYPosition)));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (segmentB | (segmentF | segmentC)) | (segmentA | (segmentE | segmentD));

        1: digitpixel <= segmentC | segmentB;

        2: digitpixel <= (segmentE | (segmentB | segmentG)) | (segmentA | segmentD);

        3: digitpixel <= (segmentC | segmentD) | (segmentG | (segmentA | segmentB));

        4: digitpixel <= (segmentF | segmentC) | (segmentB | segmentG);

        5: digitpixel <= ((segmentG | (segmentC | segmentD)) | segmentF) | segmentA;

        6: digitpixel <= segmentA | (segmentC | ((segmentG | segmentE) | (segmentF | segmentD)));

        7: digitpixel <= segmentC | (segmentA | segmentB);

        8: digitpixel <= (segmentA | (segmentF | segmentC)) | ((segmentE | (segmentB | segmentG)) | segmentD);

        9: digitpixel <= (segmentC | (segmentA | (segmentB | segmentD))) | (segmentF | segmentG);

        10: digitpixel <= ((segmentF | segmentG) | segmentC) | ((segmentA | segmentB) | segmentE);

        default: digitpixel <= 0;

      endcase

endmodule

