module rxtxdiv_m
  # (parameter HUNT = 2'b00, GRCE = 2'b01, ARMD = 2'b10, RECV = 2'b11,
     SUBDIV16 = 0, ADJUSTSAMPLEPOINT = 0
     )
   (input       clk,bitxce,load,rxpin,
    input [1:0] rxst,
    output      loadORtxce,
    output reg  rxce
    );
   localparam   rstval = SUBDIV16 ? (ADJUSTSAMPLEPOINT ? 4'b1001 : 4'b1000) :
                                    (ADJUSTSAMPLEPOINT ? 3'b101  : 3'b100);
   reg [2+SUBDIV16:0]    txcnt,rxcnt;
`ifdef SIMULATION
   initial txcnt = 0;
`endif
   always @(posedge clk) begin
      if ( bitxce ) begin
         txcnt <= txcnt + 1;
         rxcnt <= rxst == HUNT ? rstval : (rxcnt+1);
      end
      rxce <= ((rxst != HUNT) & (&rxcnt & bitxce) )
        | ((rxst == HUNT | rxst == GRCE) & rxpin);
   end
   assign loadORtxce = (&txcnt & bitxce) | load;
endmodule