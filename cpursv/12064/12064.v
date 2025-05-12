
module fifo_32x512a(aclr,data,rdclk,rdreq,wrclk,wrreq,q,rdempty,wrfull,wrusedw);

  input  aclr;
  input  [31:0] data;
  input  rdclk;
  input  rdreq;
  input  wrclk;
  input  wrreq;
  output [31:0] q;
  output rdempty;
  output wrfull;
  output [9:0] wrusedw;


endmodule

