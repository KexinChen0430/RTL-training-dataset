
module Multiplexer_AC  #(parameter  W = 32)
  (input  wire ctrl,
   input  wire [(0-1)+W:0] D0,
   input  wire [(0-1)+W:0] D1,
   output reg [(0-1)+W:0] S);

  
  always @(ctrl or D0 or D1)
      case (ctrl)

        1'b0: S <= D0;

        1'b1: S <= D1;

      endcase

endmodule

