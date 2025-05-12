
module ffq(clk,d,q);

  parameter  WIDTH = 32;
  input  clk;
  input  [(-1)+WIDTH:0] d;
  output [(-1)+WIDTH:0] q;
  reg  [(-1)+WIDTH:0] qr;

  
  always @(posedge clk)  qr <= d;
  assign q = qr;
endmodule

