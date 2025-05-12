
module ffq(clk,d,q);

  parameter  WIDTH = 32;
  input  clk;
  input  [WIDTH+(0-1):0] d;
  output [WIDTH+(0-1):0] q;
  reg  [WIDTH+(0-1):0] qr;

  
  always @(posedge clk)  qr <= d;
  assign q = qr;
endmodule

