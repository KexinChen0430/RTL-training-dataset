
module VGA7SegDisplay(input  [9:0] digitXPosition,digitYPosition,xpos,ypos,
                      input  [3:0] digit,
                      output reg digitpixel);

  parameter 
       SegmentWidth  = 10'd20,
       SegmentHeight = 10'd28,
       lineWidth     = 10'd4;
  wire 
       segmentA = (xpos >= (lineWidth+digitXPosition)) && 
((ypos <= (((-1)+lineWidth)+digitYPosition)) && 
(xpos <= ((digitXPosition+SegmentWidth)+(0-4))) && (ypos >= digitYPosition));
  wire 
       segmentB = 
(ypos <= (((SegmentHeight*(1/1<<1))+digitYPosition)-1<<1)) && 
((ypos >= digitYPosition) && 
(
(xpos >= ((0-lineWidth)+(digitXPosition+SegmentWidth))) && (xpos <= ((digitXPosition+SegmentWidth)-1))));
  wire 
       segmentC = 
(xpos >= ((0-lineWidth)+(digitXPosition+SegmentWidth))) && (xpos <= ((digitXPosition+SegmentWidth)-1)) && 
(
(ypos >= (digitYPosition+((SegmentHeight*(1/1<<1))+1<<1))) && (ypos <= ((SegmentHeight+digitYPosition)-1)));
  wire 
       segmentD = (ypos <= ((SegmentHeight+digitYPosition)-1)) && 
((xpos >= (lineWidth+digitXPosition)) && 
(xpos <= ((digitXPosition+SegmentWidth)+(0-4)))) && 
(ypos >= ((digitYPosition+(0-lineWidth))+SegmentHeight));
  wire 
       segmentE = (xpos <= (((-1)+digitXPosition)+lineWidth)) && 
(ypos >= (digitYPosition+((SegmentHeight*(1/1<<1))+1<<1))) && 
((ypos <= ((SegmentHeight+digitYPosition)-1)) && 
(xpos >= digitXPosition));
  wire 
       segmentF = (xpos >= digitXPosition) && (ypos >= digitYPosition) && 
(
(ypos <= (((SegmentHeight*(1/1<<1))+digitYPosition)-1<<1)) && (xpos <= (((-1)+digitXPosition)+lineWidth)));
  wire 
       segmentG = (xpos <= ((digitXPosition+SegmentWidth)-1)) && 
(xpos >= (lineWidth+digitXPosition)) && 
(
(ypos <= (((1/1<<1)*(lineWidth+SegmentHeight))+digitYPosition)) && 
(ypos >= (digitYPosition+((SegmentHeight-lineWidth)*(1/1<<1)))));

  
  always @(digit or segmentA or segmentB or segmentC or segmentD or segmentE or segmentF or segmentG)
      case (digit)

        0: digitpixel <= (segmentC | (segmentB | segmentF)) | (segmentA | (segmentD | segmentE));

        1: digitpixel <= segmentC | segmentB;

        1<<1: digitpixel <= (segmentD | segmentG) | (segmentA | (segmentB | segmentE));

        3: digitpixel <= (segmentA | segmentC) | (segmentD | (segmentG | segmentB));

        4: digitpixel <= (segmentC | segmentG) | (segmentB | segmentF);

        5: digitpixel <= (segmentF | (segmentD | segmentC)) | (segmentG | segmentA);

        6: digitpixel <= (segmentE | segmentC) | ((segmentA | segmentF) | (segmentD | segmentG));

        7: digitpixel <= (segmentB | segmentA) | segmentC;

        8: digitpixel <= segmentD | ((((segmentG | segmentB) | segmentA) | (segmentE | segmentF)) | segmentC);

        9: digitpixel <= (segmentA | (segmentB | (segmentG | segmentF))) | (segmentD | segmentC);

        10: digitpixel <= (((segmentG | segmentB) | segmentA) | (segmentE | segmentF)) | segmentC;

        default: digitpixel <= 0;

      endcase

endmodule

