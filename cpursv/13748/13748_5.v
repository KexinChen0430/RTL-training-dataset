
module SyncWire(DIN,DOUT);

  parameter  width = 1;
  input  [(0-1)+width:0] DIN;
  output [(0-1)+width:0] DOUT;

  assign DOUT = DIN;
endmodule

