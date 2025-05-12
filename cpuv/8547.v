module.
	ADDER adder(.add_in1(add_in1), .add_in2(add_in2), .add_out(add_out));
	initial begin
		add_in1 = 0;
		add_in2 = 0;
		#100;
		$monitor("add_in1 = %h add_in2 = %h add_out = %h", add_in1, add_in2, add_out);
		add_in1 = 32'h00110000;
		add_in2 = 32'h001100BB;
		#10;
		add_in1 = 32'h0011FF00;
		add_in2 = 32'h001100C0;
		#10;
		add_in1 = 32'h00110010;
		add_in2 = 32'h00110CCC;
	end
endmodule