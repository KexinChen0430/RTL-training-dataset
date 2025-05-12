
module vectdelay16x1(xin,yin,zin,xout,yout,zout,clk);

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
  reg  [(-1)+16:0] buffery0;
  reg  [(-1)+16:0] bufferz0;

  assign xout = bufferx0;
  assign yout = buffery0;
  assign zout = bufferz0;
  
  always @(posedge clk)
      begin
        bufferx0 <= xin;
        buffery0 <= yin;
        bufferz0 <= zin;
      end
endmodule

