module input_block
	(
		input wire clk, 
		input wire reset, 
		input  wire [`CHANNEL_WIDTH-1:0] 		input_channel_din, 
		input  wire 							busy_engine_din, 
		input  wire 							zero_credits_din, 
		output wire [(2 * `CHANNEL_WIDTH)-1:0]	plaintext_dout, 
		output wire [(2 * `CHANNEL_WIDTH)-1:0]	key_dout, 
		output wire [`CHANNEL_WIDTH-3:0]		header_flit_dout, 
		output wire 							transfer2pe_strobe_dout 
	);
	wire [`DATA_FLITS:0] 	register_enable; 
	wire 					write_strobe; 
	des_nic_input_control_unit unidad_de_control_bloque_de_entrada 
		(
			.clk	(clk), 
			.reset 	(reset), 
			.header_field_din			(input_channel_din[31]), 
			.busy_engine_din			(busy_engine_din), 
			.zero_credits_din			(zero_credits_din), 
			.transfer2pe_strobe_dout	(transfer2pe_strobe_dout), 
			.write_strobe_dout			(write_strobe), 
			.register_enable_dout		(register_enable) 
		);
	reg [`CHANNEL_WIDTH-3:0] header_flit_reg; 
	always @(posedge clk) 
		if (register_enable[0] & write_strobe) 
				header_flit_reg <= input_channel_din[29:0]; 
	reg [`CHANNEL_WIDTH-1:0] DATA_FLIT_BANK [`DATA_FLITS-1:0]; 
	genvar index; 
	generate
		for (index = 0; index < (`DATA_FLITS); index = index + 1) 
			begin: registros_interfaz_de_red 
				always @(posedge clk) 
					if (register_enable[index+1] & write_strobe) 
						DATA_FLIT_BANK[index] <= input_channel_din; 
			end
	endgenerate
		assign header_flit_dout = header_flit_reg; 
		assign plaintext_dout 	= {DATA_FLIT_BANK[0], DATA_FLIT_BANK[1]}; 
		assign key_dout 	  	= {DATA_FLIT_BANK[2], DATA_FLIT_BANK[3]}; 
endmodule