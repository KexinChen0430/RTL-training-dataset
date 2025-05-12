
module BUFG_GT_SYNC(output CESYNC,
                    output CLRSYNC,
                    input  CE,
                    input  CLK,
                    input  CLR);

  localparam  MODULE_NAME = BUFG_GT_SYNC;
  wire CE_in;
  wire CLK_in;
  wire CLR_in;

  assign CE_in = CE || (CE === 1'bz);
  assign CLK_in = CLK;
  assign CLR_in = (CLR !== 1'bz) && CLR;
  assign CESYNC = CE_in;
  assign CLRSYNC = CLR_in;
endmodule

