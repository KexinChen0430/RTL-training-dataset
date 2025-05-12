
module VGA_FIFO(aclr,data,rdclk,rdreq,wrclk,wrreq,q,rdempty,wrfull,wrusedw);

  input  aclr;
  input  [11:0] data;
  input  rdclk;
  input  rdreq;
  input  wrclk;
  input  wrreq;
  output [11:0] q;
  output rdempty;
  output wrfull;
  output [7:0] wrusedw;
  tri0 aclr;


endmodule

