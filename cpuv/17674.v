module Test (
   out,
   clk, in
   );
   input clk;
   input [31:0] in;
   output wire [31:0] out;
   reg [31:0] stage [3:0];
   genvar g;
   generate
      for (g=0; g<4; g++) begin
	 always_comb begin
	    if (g==0) stage[g] = in;
	    else stage[g] = {stage[g-1][30:0],1'b1};
	 end
      end
   endgenerate
   assign out = stage[3];
endmodule