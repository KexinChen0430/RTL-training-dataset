
module Sprite_Controller  #(parameter  SizeX = 32, SizeY = 32)
  (input  wire [9:0] iColumnCount,
   input  wire [9:0] iRowCount,
   input  wire imask,
   input  wire iEnable,
   input  wire [9:0] iPosX,
   input  wire [9:0] iPosY,
   input  wire [2:0] iColorSprite,
   input  wire [2:0] iColorBack,
   output reg [2:0] oRGB);

  
  always @(*)
      begin
        if ((imask == 1) && 
            ((iEnable == 1) && (iColumnCount <= (SizeX+iPosX))) && (iColumnCount >= iPosX) && 
            ((iRowCount >= iPosY) && (iRowCount <= (iPosY+SizeY)))) 
          begin
            oRGB <= iColorSprite;
          end
        else 
          begin
            oRGB <= iColorBack;
          end
      end
endmodule

