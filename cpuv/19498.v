module main; 
   reg a; 
   reg b; 
   wire q = a & b; 
   initial begin 
      a = 1; 
      b = 0; 
      #1; 
      if (q !== 0) begin
	 $display("FAILED -- q did not start out right: %b", q); 
	 $finish; 
      end
      b = 1; 
      if (q !== 0) begin
	 $display("FAILED -- q changed too soon? %b", q); 
	 $finish; 
      end
      if (b !== 1) begin
	 $display("FAILED -- b value did not stick: %b", b); 
	 $finish; 
      end
      #0 if (q !== 1) begin
	 $display("FAILED -- q did not change when it should: %b", q); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 