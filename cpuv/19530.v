module main; 
   reg x; 
   reg [1:0] xx; 
   initial begin 
      if (1'bx !== 1'bx) begin
	 $display("FAILED -- simple constant x does't compare."); 
	 $finish; 
      end
      if (1'bx !== !1'bx) begin
	 $display("FAILED -- !1'bx comes out wrong."); 
	 $finish; 
      end
      x = 1'bx; 
      if (x !== 1'bx) begin
	 $display("FAILED -- variable x comes out wrong."); 
	 $finish; 
      end
      x = !x; 
      if (x !== 1'bx) begin
	 $display("FAILED -- ! of variable x comes out wrong."); 
	 $finish; 
      end
      xx = 2'bx0; 
      if (xx !== 2'bx0) begin
	 $display("FAILED -- variable x comes out wrong."); 
	 $finish; 
      end
      x = !xx; 
      if (x !== 1'bx) begin
	 $display("FAILED -- ! of variable xx comes out wrong."); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 