
module vectdelay29x2(xin,yin,zin,xout,yout,zout,clk);

  input  [(0-1)+29:0] xin;
  input  [(0-1)+29:0] yin;
  input  [(0-1)+29:0] zin;
  output [(0-1)+29:0] xout;
  wire [(0-1)+29:0] xout;
  output [(0-1)+29:0] yout;
  wire [(0-1)+29:0] yout;
  output [(0-1)+29:0] zout;
  wire [(0-1)+29:0] zout;
  input  clk;
  reg  [(0-1)+29:0] bufferx0;
  reg  [(0-1)+29:0] bufferx1;
  reg  [(0-1)+29:0] buffery0;
  reg  [(0-1)+29:0] buffery1;
  reg  [(0-1)+29:0] bufferz0;
  reg  [(0-1)+29:0] bufferz1;

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

