
module ffq(clk,d,q);

  parameter  WIDTH = 32;
  input  clk;
  input  [(0-1)+WIDTH:0] d;
  output [(0-1)+WIDTH:0] q;
  reg  [(0-1)+WIDTH:0] qr;

  
  always @(posedge clk)  qr <= d;
  assign q = qr;
endmodule

