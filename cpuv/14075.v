module main;
   reg clk, bit, foo, clr; 
   always @(posedge clk or posedge clr) 
     if (clr) foo = 0; 
     else case (bit) 
       1'b0: ; 
       1'b1: foo <= ~foo; 
     endcase 
   (* ivl_synthesis_off *)
   always begin 
      #5 clk = 1; 
      #5 clk = 0; 
   end 
   (* ivl_synthesis_off *) 
   initial begin 
      clk = 0; 
      bit = 0; 
      clr = 1; 
      #6 $display("clk=%b, bit=%b, foo=%b", clk, bit, foo); 
      if (bit !== 0 || foo !== 0) begin 
	 $display("FAILED"); 
	 $finish; 
      end
      clr = 0; 
      #10 $display("clk=%b, bit=%b, foo=%b", clk, bit, foo); 
      if (bit !== 0 || foo !== 0) begin 
	 $display("FAILED"); 
	 $finish; 
      end
      bit <= 1; 
      #10 $display("clk=%b, bit=%b, foo=%b", clk, bit, foo); 
      if (bit !== 1 || foo !== 1) begin 
	 $display("FAILED"); 
	 $finish; 
      end
      #10 $display("clk=%b, bit=%b, foo=%b", clk, bit, foo); 
      if (bit !== 1 || foo !== 0) begin 
	 $display("FAILED"); 
	 $finish; 
      end
      $display("PASSED"); 
      $finish; 
   end 
endmodule 