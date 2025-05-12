module test_engine_nic_input_block
(
	input wire clk, 
	input wire reset, 
	input  wire [`CHANNEL_WIDTH-1:0] 		input_channel_din, 
	input  wire 							busy_engine_din, 
	input  wire 							zero_credits_din, 
	output wire [(2 * `CHANNEL_WIDTH)-1:0]	wordA_dout, 
	output wire [(2 * `CHANNEL_WIDTH)-1:0]	wordB_dout, 
	output wire [`CHANNEL_WIDTH-3:0]		header_flit_dout, 
	output wire 							transfer2pe_strobe_dout 
);
wire [`DATA_FLITS:0] 	register_enable;
wire 					write_strobe;
test_engine_nic_input_control_unit input_block_control_unit
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
initial
	begin: inicializacion_de_registros
		integer idx;
		for (idx = 0; idx < (`DATA_FLITS); idx = idx + 1)
				DATA_FLIT_BANK[idx] <= {`CHANNEL_WIDTH{1'b0}};
	end
assign header_flit_dout = header_flit_reg;
assign wordA_dout = {DATA_FLIT_BANK[0], DATA_FLIT_BANK[1]};
assign wordB_dout = {DATA_FLIT_BANK[2], DATA_FLIT_BANK[3]};
endmodule