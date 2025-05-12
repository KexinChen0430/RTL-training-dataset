module beta (
   clk, toggle
   );
   input clk;
   input toggle;
   always @ (posedge clk) begin
      if (0) begin
      end
      if (toggle) begin
      end
      if (toggle) begin
	 $write("");
      end
   end
endmodule