module sub3 #(
   parameter logic [7:0] P0 = 2 + 1,
   type TYPE = logic,
   parameter int UNPACKED_ARRAY[2] = '{0, 1},
   parameter logic signed [15:0] UNUSED = -3,
   parameter string STR = "str") (
   input wire clk,
   input wire [7:0] in,
   output wire [7:0] out); `HIER_BLOCK 
initial $display("P0:%d UNUSED:%d %s", P0, UNUSED, STR);
TYPE [7:0] ff;
always_ff @(posedge clk) ff <= in + P0;
always_ff @(posedge clk) if (out4 != out4_2) $stop;
wire [7:0] out4;
wire [7:0] out4_2;
assign out = out4;
sub4 #(.P0(1.6), .P1(3.1), .P3(4.1)) i_sub4_0(.clk(clk), .in(ff), .out(out4));  
sub4 #(.P0(2.4), .P1(3.1), .P3(5)) i_sub4_1(.clk(clk), .in(ff), .out(out4_2));
endmodule