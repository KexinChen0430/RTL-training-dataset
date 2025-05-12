module. 
	ALU alu(.A(A), .B(B), .control(control), .zero(zero), .result(result)); 
	initial begin 
		A = 0; 
		B = 0; 
		control = 0; 
		#100; 
		A       <= 'b1010; 
		B       <= 'b0111; 
		control <= 'b011; 
		$display("A = %b\tB = %b", A, B); 
		$monitor("ALUOp = %b\tresult = %b", control, result); 
		#1 
		control <= 'b100; 
		#1 
		control <= 'b010; 
		#1 
		control <= 'b111; 
		#1 
		control <= 'b011; 
		#1 
		control <= 'b110; 
		#1 
		control <= 'b001; 
		#1 
		control <= 'b000; 
		#1 
		$finish; 
	end 
endmodule 