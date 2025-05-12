module top; 
   reg \cpu3 ; 
   initial begin 
      cpu3 = 1; 
      $display("cpu3 == %b", \cpu3 ); 
      if (top.\cpu3  !== cpu3) begin 
	 $display("FAILED -- top.\\cpu3 !== cpu3"); 
	 $finish; 
      end
      if (\top .cpu3  !== \cpu3 ) begin 
	 $display("FAILED -- \\top .cpu3 !== cpu3"); 
	 $finish; 
      end
      if (top.\cpu3  !== 1) begin 
	 $display("FAILED -- top.\\cpu3 !== 1"); 
	 $finish; 
      end
      $display("PASSED"); 
   end
endmodule 