
module Castle(clk_vga,CurrentX,CurrentY,mapData,wall);

  input  clk_vga;
  input  [9:0] CurrentX;
  input  [8:0] CurrentY;
  input  [7:0] wall;
  output [7:0] mapData;
  reg  [7:0] mColor;

  
  always @(posedge clk_vga)
      begin
        if ((CurrentX >= 0) && (CurrentX <= 31)) mColor[7:0] <= wall;
        else if (CurrentX >= 608) mColor[7:0] <= wall;
        else if ((CurrentY >= 441) && 
                 ((CurrentX <= 256) || (CurrentX >= 384))) mColor[7:0] <= wall;
        else if ((CurrentY <= 39) && 
                 ((CurrentX >= 480) || (CurrentX <= 159))) mColor[7:0] <= wall;
        else mColor[7:0] <= 8'b10110110;
      end
  assign mapData = mColor;
endmodule

