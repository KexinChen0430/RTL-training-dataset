
module IPfifo(aclr,data,rdclk,rdreq,wrclk,wrreq,q,rdempty,rdusedw,wrempty,
              wrusedw);

  input  aclr;
  input  [9:0] data;
  input  rdclk;
  input  rdreq;
  input  wrclk;
  input  wrreq;
  output [9:0] q;
  output rdempty;
  output [13:0] rdusedw;
  output wrempty;
  output [13:0] wrusedw;
  tri0 aclr;


endmodule

