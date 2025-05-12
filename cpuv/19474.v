module main; 
   reg  [3:0] a = 4'b0110; 
   reg [1:0]  s = 0; 
   wire       b = a[s]; 
   initial begin 
      #1 if (b !== 0) begin 
	 $display("FAILED -- a=%b, s=%b, b=%b", a, s, b); 
	 $finish; 
      end
      s = 1; 
      #1 if (b !== 1) begin 
	 $display("FAILED -- a=%b, s=%b, b=%b", a, s, b); 
	 $finish; 
      end
      s = 2; 
      #1 if (b !== 1) begin 
	 $display("FAILED -- a=%b, s=%b, b=%b", a, s, b); 
	 $finish; 
      end
      s = 3; 
      #1 if (b !== 0) begin 
	 $display("FAILED -- a=%b, s=%b, b=%b", a, s, b); 
	 $finish; 
      end
      s = 2'bxx; 
      #1 if (b !== 1'bx) begin 
	 $display("FAILED -- a=%b, s=%b, b=%b", a, s, b); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 