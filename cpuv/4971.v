module decoder_complex_tb;
	reg [7:0] opcode;
	reg clk;
	wire [5:0] rom_offset;
	decoder_complex uut (
			.opcode(opcode),
			.rom_offset(rom_offset)
		);
	initial begin
		opcode = 0;
		clk = 0;
		#1000	$finish;
	end
	always
		#50		clk = ~clk;
	always @(posedge clk)
		opcode = opcode + 1'b1;
endmodule