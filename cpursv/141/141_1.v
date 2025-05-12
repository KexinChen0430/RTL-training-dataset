
module fifo_1kx16(aclr,clock,data,rdreq,wrreq,almost_empty,empty,full,q,usedw);

  input  aclr;
  input  clock;
  input  [15:0] data;
  input  rdreq;
  input  wrreq;
  output almost_empty;
  output empty;
  output full;
  output [15:0] q;
  output [9:0] usedw;


endmodule

