
module basicreg(clk,d,q);

  input  clk,d;
  output [2:0] q;
  reg  [2:0] q;

  
  always @(posedge clk)  begin
    q <= d<<1;
  end
endmodule

