
module SCenterMaze(clk_vga,CurrentX,CurrentY,mapData,wall);

  input  clk_vga;
  input  [9:0] CurrentX;
  input  [8:0] CurrentY;
  input  [7:0] wall;
  output [7:0] mapData;
  reg  [7:0] mColor;

  
  always @(posedge clk_vga)
      begin
        if (
(
((CurrentY >= 120) || 
((CurrentY >= 120) && (CurrentY >= 441)) || (CurrentY >= 441) || 
((CurrentY <= 39) || 
((CurrentY >= 120) && (CurrentY <= 359)))) && (CurrentY <= 359) && 
((CurrentX >= 0) && (CurrentX <= 63))) || 
            (((CurrentY <= 39) || (CurrentY >= 441)) && 
((CurrentY <= 39) && (CurrentX <= 63) && (CurrentX >= 0))) || 
            (
((CurrentY <= 39) && (CurrentX <= 63) && (CurrentX >= 0)) || 
((CurrentX >= 0) && (CurrentX <= 63) && (CurrentY >= 441)))) mColor[7:0] <= wall;
        else mColor[7:0] <= 8'b10110110;
      end
  assign mapData = mColor;
endmodule

