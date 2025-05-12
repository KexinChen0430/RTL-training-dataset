module
	S_EXTEND #(.IN_SIZE(IN_SIZE), .OUT_SIZE(OUT_SIZE)) s_extend (.din(din), .dout(dout)); 
	initial begin
		din = 16'b0000000000000000; 
		#100; 
		din = 16'b1000001100000100; 
		#10; 
		din = 16'b0011001100000100; 
		#10; 
		din = 16'b0111001100111101; 
		#10; 
		din = 16'b1111001100000100; 
	end
	initial begin
		$monitor("in = %b\tout = %b", din, dout);
	end
endmodule