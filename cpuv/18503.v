module sub0 #(
   parameter logic UNPACKED[0:1] = '{1'b0, 1'b1}
   ) (
   input wire clk,
   input wire [7:0] in,
   output wire [7:0] out); `HIER_BLOCK
   logic [7:0] ff;
   always_ff @(posedge clk) ff <= in;
   assign out = ff;
endmodule