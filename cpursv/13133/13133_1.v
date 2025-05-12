
module small_fifo_test_72(clock,data,rdreq,sclr,wrreq,empty,full,q,usedw);

  input  clock;
  input  [71:0] data;
  input  rdreq;
  input  sclr;
  input  wrreq;
  output empty;
  output full;
  output [71:0] q;
  output [7:0] usedw;


endmodule

