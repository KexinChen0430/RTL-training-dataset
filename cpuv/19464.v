module main; 
   reg [1:0] out; 
   initial begin 
      out = 2'b0; 
      if (out !== 2'b0) begin 
	 $display("FAILED to initialize:  out == %b", out); 
	 $finish; 
      end
      out <= #5 2'b1; 
      if (out !== 2'b0) begin 
	 $display("FAILED -- changed immediately: out == %b", out); 
	 $finish; 
      end
      #4 if (out !== 2'b0) begin 
	 $display("FAILED -- changed too soon: out == %b", out); 
	 $finish; 
      end
      #2 if (out !== 2'b1) begin 
	 $display("FAILED to change after delay: out == %b", out); 
	 $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 