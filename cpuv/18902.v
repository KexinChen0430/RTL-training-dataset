module main; 
   reg [7:0] testr; 
   wire [7:0] testw = {-5'd1, -3'sd1}; 
   initial begin 
      #1 testr = {-5'd1, -3'sd1}; 
      if (testr !== 8'b11111_111) begin
	 $display("FAILED -- testr=%b", testr); 
	 $finish; 
      end
      if (testw !== 8'b11111_111) begin
	 $display("FAILED -- testw=%b", testw); 
	 $finish; 
      end
      $display("testr=%b", testr);
      $display("testw=%b", testw);
      $display("PASSED"); 
   end 
endmodule 