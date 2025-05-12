module main; 
   reg enable, val; 
   tri1 t1 = enable ? val : 1'bz; 
   initial begin 
      enable = 0; 
      val = 0; 
      #1 if (t1 !== 1'b1) begin 
	 $display("FAILED -- undriven t1 == %b", t1); 
	 $finish; 
      end
      enable = 1; 
      #1 if (t1 !== 1'b0) begin 
	 $display("FAILED -- driven-0 t1 == %b", t1); 
	 $finish; 
      end
      val = 1; 
      #1 if (t1 !== 1'b1) begin 
	 $display("FAILED -- driven-1 t1 == %b", t1); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 