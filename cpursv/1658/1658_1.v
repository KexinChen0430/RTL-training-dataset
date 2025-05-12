
module fifo_181x128a(aclr,data,rdclk,rdreq,wrclk,wrreq,q,rdempty,wrempty,wrusedw);

  input  aclr;
  input  [180:0] data;
  input  rdclk;
  input  rdreq;
  input  wrclk;
  input  wrreq;
  output [180:0] q;
  output rdempty;
  output wrempty;
  output [6:0] wrusedw;
  tri0 aclr;


endmodule

