module fifo_generator_v13_1_3_sync_stage
  #(
    parameter  C_WIDTH          = 10
   )
   (
    input                     RST,
    input                     CLK,
    input       [C_WIDTH-1:0] DIN,
    output reg  [C_WIDTH-1:0] DOUT = 0
   );
   always @ (posedge RST or posedge CLK) begin
     if (RST)
       DOUT <= 0;
     else
       DOUT <= #`TCQ DIN;
   end
endmodule