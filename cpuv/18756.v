module clkgen
  (
   CLK_RING_ENn, 
   CLK_GATE,	 
   CLK_TUNE,	 
   CLK_OUT
   );
   input       CLK_RING_ENn;
   input       CLK_GATE;
   input [3:0] CLK_TUNE;
   output reg  CLK_OUT;
   initial begin
      CLK_OUT <= 1'b0;
   end
   always @ (CLK_RING_ENn or CLK_GATE or CLK_OUT) begin
      if (~CLK_RING_ENn && ~CLK_GATE) begin
	 `CLK_HALF_PERIOD;
	 CLK_OUT <= ~CLK_OUT;
      end
      else begin
	 CLK_OUT <= 1'b0;
      end
   end
   always @(CLK_TUNE) begin
      $write("%c[1;34m",27);
      $display("CLKGEN Input CLK_TUNE Has been changed to:%x", CLK_TUNE);
      $write("%c[0m",27);
   end
endmodule