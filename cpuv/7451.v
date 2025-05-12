module vio_sync_out32
  (
    control,
    clk,
    sync_out
  )
  ;
  input  [35:0] control;
  input  clk;
  output [31:0] sync_out;
endmodule