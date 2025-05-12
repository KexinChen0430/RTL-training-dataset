
module BUFG_GT_SYNC(output CESYNC,
                    output CLRSYNC,
                    input  CE,
                    input  CLK,
                    input  CLR);

  localparam  MODULE_NAME = BUFG_GT_SYNC;

  assign CESYNC = CE || (CE === 1'bz);
  assign CLRSYNC = CLR && (CLR !== 1'bz);
endmodule

