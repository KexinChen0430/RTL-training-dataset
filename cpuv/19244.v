module Test (
   out,
   clk, in
   );
   input clk; 
   input  [31:0] in; 
   output [3:0] out; 
   assign 	out[0] = in[3:0] ==? 4'b1001;
   assign 	out[1] = in[3:0] !=? 4'b1001;
   assign 	out[2] = in[3:0] ==? 4'bx01x;
   assign 	out[3] = in[3:0] !=? 4'bx01x;
   wire signed [3:0] ins = in[3:0];
   wire signed [3:0] outs;
   assign 	outs[0] = ins ==? 4'sb1001;
   assign 	outs[1] = ins !=? 4'sb1001;
   assign 	outs[2] = ins ==? 4'sbx01x;
   assign 	outs[3] = ins !=? 4'sbx01x;
   always_comb if (out != outs) $stop;
endmodule 