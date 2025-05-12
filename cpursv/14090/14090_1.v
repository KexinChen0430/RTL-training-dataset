
module IMG_BUFFER(data,rdaddress,rdclock,wraddress,wrclock,wren,q);

  input  [7:0] data;
  input  [10:0] rdaddress;
  input  rdclock;
  input  [10:0] wraddress;
  input  wrclock;
  input  wren;
  output [7:0] q;
  tri1 wren;


endmodule

