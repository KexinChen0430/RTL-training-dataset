
module basicreg(clk,d,q);

  input  clk,d;
  output [2:0] q;
  reg  [2:0] q;

  
  always @(posedge clk)  begin
    q <= 2*d;
  end
endmodule

