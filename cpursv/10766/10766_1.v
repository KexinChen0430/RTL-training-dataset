
module ram(address,byteena,clock,data,rden,wren,q);

  input  [9:0] address;
  input  [3:0] byteena;
  input  clock;
  input  [31:0] data;
  input  rden;
  input  wren;
  output [31:0] q;
  tri1 [3:0] byteena;
  tri1 clock;
  tri1 rden;


endmodule

