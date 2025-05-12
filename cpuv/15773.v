module ZHOLD_DELAY #(
`ifdef XIL_TIMING
   parameter LOC = "UNPLACED",
`endif 
   parameter [0:0] IS_DLYIN_INVERTED = 1'b0,
   parameter ZHOLD_FABRIC = "DEFAULT",
   parameter ZHOLD_IFF = "DEFAULT"
) (
   output    DLYFABRIC,
   output    DLYIFF,
   input     DLYIN
);
   localparam MODULE_NAME = "ZHOLD_DELAY";
   localparam MAX_IFF_DELAY_COUNT = 31;
   localparam MIN_IFF_DELAY_COUNT = 0;
   localparam MAX_IDELAY_COUNT = 31;
   localparam MIN_IDELAY_COUNT = 0;
`ifndef XIL_TIMING
   real TAP_DELAY = 200.0;
`endif 
   integer idelay_count=0;
   integer iff_idelay_count=0;
   wire dlyin_in;
`ifndef XIL_TIMING
   reg tap_out_fabric = 0;
   reg tap_out_iff = 0;
`endif 
`ifdef XIL_TIMING
   assign #1 DLYFABRIC = dlyin_in;
   assign #1 DLYIFF    = dlyin_in;
`else  
   assign DLYFABRIC = tap_out_fabric;
   assign DLYIFF = tap_out_iff;
`endif 
   assign dlyin_in = IS_DLYIN_INVERTED ^ DLYIN;
   initial begin
       case (ZHOLD_FABRIC)
       endcase
   end 
`ifndef XIL_TIMING
   always@(dlyin_in) begin
       tap_out_fabric <= #(TAP_DELAY*idelay_count) dlyin_in;
       tap_out_iff    <= #(TAP_DELAY*iff_idelay_count) dlyin_in;
   end  
`endif 
   specify
`ifdef XIL_TIMING
       ( DLYIN => DLYFABRIC) = (0:0:0, 0:0:0);
       ( DLYIN => DLYIFF)    = (0:0:0, 0:0:0);
`endif 
       specparam PATHPULSE$ = 0;
   endspecify
endmodule