
module ram_128_32x32_dp(data,rdaddress,rdclock,wraddress,wrclock,wren,q);

  input  [127:0] data;
  input  [3:0] rdaddress;
  input  rdclock;
  input  [1:0] wraddress;
  input  wrclock;
  input  wren;
  output [31:0] q;


endmodule

