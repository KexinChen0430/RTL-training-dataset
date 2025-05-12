module main; 
   reg [6:0] a, b; 
   reg       sel; 
   wire [6:0] test = sel ? a : b; 
   wire [7:0] test2 = test; 
   initial begin 
      sel = 0; 
      #1 $display("sel=%b, test2=%b", sel, test2); 
      b = 0; 
      #1 $display("sel=b, test2=%b", sel, test2); 
      if (test2 !== 8'b0_0000000) begin 
	 $display("FAILED"); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 