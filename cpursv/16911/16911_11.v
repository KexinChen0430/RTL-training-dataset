
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (ypos >= digitYPosition) && 
((xpos <= ((SegmentWidth+digitXPosition)-4)) && 
(xpos >= (lineWidth+digitXPosition)) && (ypos <= ((lineWidth+(-1))+digitYPosition)));
  wire 
       segmentB = 
(xpos >= ((SegmentWidth+digitXPosition)-lineWidth)) && (xpos <= (SegmentWidth+(digitXPosition+(-1)))) && 
((ypos >= digitYPosition) && 
(ypos <= ((-1<<<1)+(digitYPosition+((1/1<<<1)*SegmentHeight)))));
  wire 
       segmentC = 
(ypos >= (1<<<1+(digitYPosition+((1/1<<<1)*SegmentHeight)))) && 
((ypos <= ((SegmentHeight+digitYPosition)+(-1))) && 
(
(xpos >= ((SegmentWidth+digitXPosition)-lineWidth)) && (xpos <= (SegmentWidth+(digitXPosition+(-1))))));
  wire 
       segmentD = (xpos <= ((SegmentWidth+digitXPosition)-4)) && 
(xpos >= (lineWidth+digitXPosition)) && 
(
(ypos >= (((-lineWidth)+SegmentHeight)+digitYPosition)) && (ypos <= ((SegmentHeight+digitYPosition)+(-1))));
  wire 
       segmentE = (xpos <= ((lineWidth+digitXPosition)+(-1))) && 
(ypos >= (1<<<1+(digitYPosition+((1/1<<<1)*SegmentHeight)))) && 
((ypos <= ((SegmentHeight+digitYPosition)+(-1))) && 
(xpos >= digitXPosition));
  wire 
       segmentF = (ypos >= digitYPosition) && 
(ypos <= ((-1<<<1)+(digitYPosition+((1/1<<<1)*SegmentHeight)))) && 
((xpos <= ((lineWidth+digitXPosition)+(-1))) && 
(xpos >= digitXPosition));
  wire 
       segmentG = (xpos >= (lineWidth+digitXPosition)) && 
(
(ypos <= (digitYPosition+((SegmentHeight+lineWidth)*(1/1<<<1)))) && 
(ypos >= (digitYPosition+(((-lineWidth)+SegmentHeight)*(1/1<<<1))))) && (xpos <= (SegmentWidth+(digitXPosition+(-1))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= ((segmentE | segmentF) | (segmentD | segmentC)) | (segmentB | segmentA);

        1: digitpixel <= segmentB | segmentC;

        1<<<1: digitpixel <= ((segmentD | segmentB) | segmentA) | (segmentG | segmentE);

        3: digitpixel <= ((segmentD | (segmentC | segmentG)) | segmentB) | segmentA;

        4: digitpixel <= ((segmentG | segmentB) | segmentC) | segmentF;

        5: digitpixel <= (segmentA | segmentF) | (segmentD | (segmentC | segmentG));

        6: digitpixel <= (segmentA | (segmentC | segmentG)) | ((segmentE | segmentD) | segmentF);

        7: digitpixel <= (segmentB | segmentC) | segmentA;

        8: digitpixel <= (segmentA | (segmentC | segmentG)) | (((segmentE | segmentD) | segmentF) | segmentB);

        9: digitpixel <= ((segmentD | segmentB) | segmentA) | ((segmentF | segmentG) | segmentC);

        10: digitpixel <= segmentA | ((segmentF | segmentG) | (segmentE | (segmentB | segmentC)));

        default: digitpixel <= 0;

      endcase

endmodule

