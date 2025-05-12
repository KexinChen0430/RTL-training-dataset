module test; 
   reg [3:0] val, y; 
   initial begin 
      val = 2; 
      y = !{!val}; 
      if (y !== 4'b0001) begin
	 $display("FAILED -- !!4'b%b --> 4'b%b", val, y);
	 $finish; 
      end
      $display("PASSED");
   end 
endmodule 