
module sram(clock,data,rdaddress,wraddress,wren,q);

  input  clock;
  input  [15:0] data;
  input  [11:0] rdaddress;
  input  [11:0] wraddress;
  input  wren;
  output [15:0] q;
  tri1 clock;
  tri0 wren;


endmodule

