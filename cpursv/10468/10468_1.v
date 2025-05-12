
module COMMAND_PAGE(clock,data,rdaddress,wraddress,wren,q);

  input  clock;
  input  [15:0] data;
  input  [7:0] rdaddress;
  input  [8:0] wraddress;
  input  wren;
  output [31:0] q;
  tri1 clock;
  tri0 wren;


endmodule

