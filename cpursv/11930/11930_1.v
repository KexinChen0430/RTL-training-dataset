
module sfifo_65x128(data,wrreq,rdreq,clock,aclr,q,full,empty,usedw,almost_full);

  input  [64:0] data;
  input  wrreq;
  input  rdreq;
  input  clock;
  input  aclr;
  output [64:0] q;
  output full;
  output empty;
  output [6:0] usedw;
  output almost_full;


endmodule

