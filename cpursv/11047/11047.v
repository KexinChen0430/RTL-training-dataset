
module fifo_99x128(clock,data,rdreq,wrreq,empty,full,q,usedw);

  input  clock;
  input  [98:0] data;
  input  rdreq;
  input  wrreq;
  output empty;
  output full;
  output [98:0] q;
  output [6:0] usedw;


endmodule

