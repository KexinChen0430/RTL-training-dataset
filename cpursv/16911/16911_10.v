
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos <= ((digitYPosition+lineWidth)-1)) && 
(xpos >= (lineWidth+digitXPosition)) && 
((ypos >= digitYPosition) && 
(xpos <= ((digitXPosition+SegmentWidth)-4)));
  wire 
       segmentB = 
(ypos <= ((digitYPosition+(-1<<<1))+(SegmentHeight*(1/1<<<1)))) && 
((xpos <= (((0-1)+digitXPosition)+SegmentWidth)) && 
(ypos >= digitYPosition)) && 
(xpos >= ((digitXPosition+SegmentWidth)+(0-lineWidth)));
  wire 
       segmentC = (ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(xpos <= (((0-1)+digitXPosition)+SegmentWidth)) && 
(xpos >= ((digitXPosition+SegmentWidth)+(0-lineWidth))) && 
(ypos >= ((1+(1+(SegmentHeight*(1/1<<<1))))+digitYPosition));
  wire 
       segmentD = (ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(ypos >= ((SegmentHeight+digitYPosition)+(0-lineWidth))) && (xpos <= ((digitXPosition+SegmentWidth)-4)) && 
(xpos >= (lineWidth+digitXPosition));
  wire 
       segmentE = (xpos <= ((lineWidth+digitXPosition)-1)) && 
((ypos <= ((0-1)+(SegmentHeight+digitYPosition))) && 
(ypos >= ((1+(1+(SegmentHeight*(1/1<<<1))))+digitYPosition))) && (xpos >= digitXPosition);
  wire 
       segmentF = 
(ypos <= ((digitYPosition+(-1<<<1))+(SegmentHeight*(1/1<<<1)))) && (xpos <= ((lineWidth+digitXPosition)-1)) && 
((xpos >= digitXPosition) && (ypos >= digitYPosition));
  wire 
       segmentG = 
(ypos >= (digitYPosition+((SegmentHeight-lineWidth)*(1/1<<<1)))) && (xpos <= (((0-1)+digitXPosition)+SegmentWidth)) && 
(xpos >= (lineWidth+digitXPosition)) && 
(ypos <= (digitYPosition+((1/1<<<1)*(SegmentHeight+lineWidth))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentB | segmentF) | (segmentC | segmentD)) | (segmentA | segmentE);

        1: digitpixel <= segmentB | segmentC;

        1<<<1: digitpixel <= (segmentB | segmentD) | ((segmentG | segmentE) | segmentA);

        3: digitpixel <= segmentB | (segmentG | (segmentD | (segmentC | segmentA)));

        4: digitpixel <= segmentC | (segmentF | (segmentG | segmentB));

        5: digitpixel <= (segmentG | segmentD) | (segmentC | (segmentA | segmentF));

        6: digitpixel <= ((segmentC | (segmentA | segmentF)) | segmentD) | (segmentG | segmentE);

        7: digitpixel <= segmentC | (segmentB | segmentA);

        8: digitpixel <= (segmentD | (segmentC | segmentA)) | (segmentE | (segmentF | (segmentG | segmentB)));

        9: digitpixel <= (segmentB | segmentA) | ((segmentD | segmentF) | (segmentG | segmentC));

        10: digitpixel <= ((segmentB | segmentA) | (segmentG | segmentE)) | (segmentC | segmentF);

        default: digitpixel <= 0;

      endcase

endmodule

