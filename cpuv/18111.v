module Test(
   o0,
   clk, i
   );
   input wire clk;
   input wire [1:0] i;
   output reg o0;
   typedef struct packed {
      logic v0, v1;
   } packed_type0;
   packed_type0 value0 `SPLIT_VAR_COMMENT;
   wire value0_v0;
   assign value0.v0 = i[0];
   assign value0.v1 = i[1] & !value0_v0;
   assign value0_v0 = value0.v0;
   always_ff @(posedge clk) begin
      o0 <= |value0;
   end
endmodule