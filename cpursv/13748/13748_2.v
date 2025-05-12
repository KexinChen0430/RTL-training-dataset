
module SyncWire(DIN,DOUT);

  parameter  width = 1;
  input  [(-1)+width:0] DIN;
  output [(-1)+width:0] DOUT;

  assign DOUT = DIN;
endmodule

