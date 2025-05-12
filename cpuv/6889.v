module generation */
	always @(posedge clk) begin
		if(write_enable)
			memory[address] <= data_in;
		data_out <= memory[address];
	end
endmodule