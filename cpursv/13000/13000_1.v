
module BROM(input  [7:1] adr_i,
            input  stb_i,
            output ack_o,
            output [15:0] dat_o);

  reg  [15:0] dat_o;

  assign ack_o = stb_i;
  
  always @(*)
      begin
        case (adr_i)

          7'd0: dat_o = 16'h0113;

          7'd1: dat_o = 16'h0000;

        endcase

      end
endmodule

