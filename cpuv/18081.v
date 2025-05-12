module sub0(
   input wire clk,
   input wire [7:0] in,
   output wire [7:0] out); `HIER_BLOCK
   logic [7:0] ff;
   always_ff @(posedge clk) ff <= in;
   assign out = ff;
endmodule