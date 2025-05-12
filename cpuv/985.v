module register_file
	(
		input 	wire 	clk, 
		input 	wire 						write_strobe_din, 
		input 	wire [ADDR_WIDTH-1:0]		write_address_din, 
		input 	wire [`CHANNEL_WIDTH-1:0]	write_data_din, 
		input 	wire [ADDR_WIDTH-1:0]		read_address_din, 
		output 	wire [`CHANNEL_WIDTH-1:0]	read_data_dout 
    );
	localparam  ADDR_WIDTH = clog2(`BUFFER_DEPTH);
	reg [`CHANNEL_WIDTH-1:0]	REG_FILE [0:`BUFFER_DEPTH-1];
	always @(posedge clk)
		if (write_strobe_din) 
				REG_FILE[write_address_din] <= write_data_din; 
	assign read_data_dout = REG_FILE[read_address_din];
			integer rf_index; 
			initial
				for (rf_index = 0; rf_index < `BUFFER_DEPTH; rf_index = rf_index + 1)
					REG_FILE[rf_index] = {`CHANNEL_WIDTH{1'b0}}; 
			function integer clog2;
				input integer depth; 
				begin
					for (clog2=0; depth>0; clog2=clog2+1) 
						depth = depth >> 1; 
				end
			endfunction
endmodule