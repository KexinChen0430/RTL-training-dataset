module main; 
   reg [3:0] mem [2:0]; 
   reg       a, b; 
   initial begin 
      mem[0] = 0; 
      mem[1] = 0; 
      mem[2] = 0; 
      {b, mem[1], a} = 6'b0_0000_1; 
      if (a !== 1'b1) begin 
	 $display("FAILED -- a = %b", a); 
	 $finish; 
      end
      if (mem[1] !== 4'b0000) begin 
	 $display("FAILED -- mem[1] = %b", mem[1]); 
	 $finish; 
      end
      if (b !== 1'b0) begin 
	 $display("FAILED -- b = %b", b); 
	 $finish; 
      end
      {b, mem[1], a} = 6'b0_1111_0; 
      if (a !== 1'b0) begin 
	 $display("FAILED -- a = %b", a); 
	 $finish; 
      end
      if (mem[0] !== 4'b0000) begin 
	 $display("FAILED -- mem[0] - %b", mem[0]); 
	 $finish; 
      end
      if (mem[1] !== 4'b1111) begin 
	 $display("FAILED -- mem[1] = %b", mem[1]); 
	 $finish; 
      end
      if (b !== 1'b0) begin 
	 $display("FAILED -- b = %b", b); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 