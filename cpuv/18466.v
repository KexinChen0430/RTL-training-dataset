module t (
   clk
   );
   input clk;
   wire  a = clk;
   wire  b = 1'b0;
   reg   c;
   test test_i (
		.clk			(clk)); 
   always @(posedge clk) begin
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule