
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos >= digitYPosition) && 
(xpos >= (digitXPosition+lineWidth)) && 
((xpos <= ((digitXPosition+SegmentWidth)-4)) && 
(ypos <= (lineWidth+((0-1)+digitYPosition))));
  wire 
       segmentB = 
(xpos >= (SegmentWidth+((0-lineWidth)+digitXPosition))) && 
(ypos <= (((SegmentHeight/2)+digitYPosition)+(0-2))) && 
((ypos >= digitYPosition) && 
(xpos <= ((0-1)+(digitXPosition+SegmentWidth))));
  wire 
       segmentC = (ypos <= (SegmentHeight+((0-1)+digitYPosition))) && 
(xpos >= (SegmentWidth+((0-lineWidth)+digitXPosition))) && 
((ypos >= (2+((SegmentHeight/2)+digitYPosition))) && 
(xpos <= ((0-1)+(digitXPosition+SegmentWidth))));
  wire 
       segmentD = (xpos <= ((digitXPosition+SegmentWidth)-4)) && 
(xpos >= (digitXPosition+lineWidth)) && 
((ypos <= (SegmentHeight+((0-1)+digitYPosition))) && 
(ypos >= ((digitYPosition+SegmentHeight)-lineWidth)));
  wire 
       segmentE = (xpos <= ((digitXPosition+lineWidth)+(0-1))) && 
(ypos <= (SegmentHeight+((0-1)+digitYPosition))) && 
((ypos >= (2+((SegmentHeight/2)+digitYPosition))) && 
(xpos >= digitXPosition));
  wire 
       segmentF = 
(ypos <= (((SegmentHeight/2)+digitYPosition)+(0-2))) && 
((ypos >= digitYPosition) && (xpos >= digitXPosition)) && (xpos <= ((digitXPosition+lineWidth)+(0-1)));
  wire 
       segmentG = 
(ypos <= (digitYPosition+((1/2)*(SegmentHeight+lineWidth)))) && (xpos <= ((0-1)+(digitXPosition+SegmentWidth))) && 
((xpos >= (digitXPosition+lineWidth)) && 
(ypos >= (digitYPosition+((SegmentHeight-lineWidth)/2))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentB | segmentA) | (segmentE | segmentF)) | (segmentC | segmentD);

        1: digitpixel <= segmentC | segmentB;

        2: digitpixel <= (segmentB | segmentD) | (segmentA | (segmentG | segmentE));

        3: digitpixel <= (segmentG | segmentC) | ((segmentB | segmentD) | segmentA);

        4: digitpixel <= (segmentF | segmentG) | (segmentC | segmentB);

        5: digitpixel <= (segmentA | (segmentG | segmentD)) | (segmentC | segmentF);

        6: digitpixel <= ((segmentG | segmentC) | segmentD) | (segmentE | (segmentF | segmentA));

        7: digitpixel <= segmentC | (segmentB | segmentA);

        8: digitpixel <= ((segmentB | segmentD) | (segmentG | (segmentC | segmentF))) | (segmentA | segmentE);

        9: digitpixel <= (segmentA | (segmentG | segmentD)) | ((segmentC | segmentF) | segmentB);

        10: digitpixel <= ((segmentC | segmentF) | segmentB) | (segmentA | (segmentG | segmentE));

        default: digitpixel <= 0;

      endcase

endmodule

