
module vectdelay16x2(xin,yin,zin,xout,yout,zout,clk);

  input  [(-1)+16:0] xin;
  input  [(-1)+16:0] yin;
  input  [(-1)+16:0] zin;
  output [(-1)+16:0] xout;
  wire [(-1)+16:0] xout;
  output [(-1)+16:0] yout;
  wire [(-1)+16:0] yout;
  output [(-1)+16:0] zout;
  wire [(-1)+16:0] zout;
  input  clk;
  reg  [(-1)+16:0] bufferx0;
  reg  [(-1)+16:0] bufferx1;
  reg  [(-1)+16:0] buffery0;
  reg  [(-1)+16:0] buffery1;
  reg  [(-1)+16:0] bufferz0;
  reg  [(-1)+16:0] bufferz1;

  assign xout = bufferx1;
  assign yout = buffery1;
  assign zout = bufferz1;
  
  always @(posedge clk)
      begin
        bufferx0 <= xin;
        buffery0 <= yin;
        bufferz0 <= zin;
        bufferx1 <= bufferx0;
        buffery1 <= buffery0;
        bufferz1 <= bufferz0;
      end
endmodule

