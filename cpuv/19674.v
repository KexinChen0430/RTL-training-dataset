module main; 
   reg [31:0] bool idx; 
   reg logic [7:0] tmp; 
   initial begin 
      idx = 7; 
      tmp = 7; 
      $display("Dispay of 7s: %d, %d", idx, tmp); 
      for (idx = 0 ;  idx < 17 ;  idx = idx + 1) begin 
	 tmp = idx[7:0]; 
	 if (tmp != idx[7:0]) begin 
	    $display("FAILED -- %b != %b", tmp, idx[7:0]); 
	    $finish; 
	 end
      end
      $display("PASSED"); 
   end 
endmodule 