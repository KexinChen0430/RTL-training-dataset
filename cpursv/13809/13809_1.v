
module dpth_br_cnd(input  wire z,
                   output wire n,
                   output wire [2:0] irc,
                   output reg cond);

  
  always @(*)
      begin : p_br_cond
        case (irc)

          3'b000: cond = 1'b1;

          3'b001: cond = z;

          3'b010: cond = n;

          3'b011: cond = z | n;

          3'b100: cond = 1'b0;

          3'b101: cond = ~z;

          3'b110: cond = ~n;

          3'b111: cond = ~(z | n);

        endcase

      end
endmodule

