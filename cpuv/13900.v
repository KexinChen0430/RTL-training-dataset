module.
	ALU_CONTROL alu_control(.funct(funct), .alu_op(alu_op), .select(select));
	initial begin
		funct = 0;
		alu_op = 0;
		#100;
		alu_op = 2'b00;
		funct = 6'b100000;
		$monitor("ALUop = %b\tfunct = %b\tselect = %b", alu_op, funct, select);
		#1
		alu_op = 2'b01;
		funct = 6'b100000;
		#1
		alu_op = 2'b10;
		funct = 6'b100000;
		#1
		funct = 6'b100010;
		#1
		funct = 6'b100100;
		#1
		funct = 6'b100101;
		#1
		funct = 6'b101010;
		#1
		$finish;
	end
endmodule