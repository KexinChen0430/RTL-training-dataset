
module Castle(clk_vga,CurrentX,CurrentY,mapData,wall);

  input  clk_vga;
  input  [9:0] CurrentX;
  input  [8:0] CurrentY;
  input  [7:0] wall;
  output [7:0] mapData;
  reg  [7:0] mColor;

  
  always @(posedge clk_vga)
      begin
        if ((CurrentX <= 31) && (CurrentX >= 0)) mColor[7:0] <= wall;
        else if (CurrentX >= 608) mColor[7:0] <= wall;
        else if (
((CurrentX >= 384) || 
((CurrentX <= 256) && (CurrentY >= 441))) && (CurrentY >= 441)) mColor[7:0] <= wall;
        else if (((CurrentX >= 480) || (CurrentX <= 159)) && 
                 ((CurrentX >= 480) || (CurrentY <= 39)) && (CurrentY <= 39)) mColor[7:0] <= wall;
        else mColor[7:0] <= 8'b10110110;
      end
  assign mapData = mColor;
endmodule

