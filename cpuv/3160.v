module test_engine_nic_output_block
	(
		input  wire clk,
		input  wire reset,
		input  wire 							done_strobe_din,
		input  wire [(2* `CHANNEL_WIDTH)-1:0] 	wordC_din,
		input  wire [(2* `CHANNEL_WIDTH)-1:0] 	wordD_din,
		input  wire [`CHANNEL_WIDTH-1:0] 		shifted_header_din,
		output wire zero_credits_dout,
		input  wire 					credit_in_din,
		output reg [`CHANNEL_WIDTH-1:0]	output_channel_dout
	);
	wire [2:0]	output_selector;
	test_engine_nic_output_control_unit  test_engine_nic_output_control_unit
		(
			.clk	(clk),
			.reset	(reset),
			.credit_in_din			(credit_in_din),
			.done_strobe_din		(done_strobe_din),
			.zero_credits_dout		(zero_credits_dout),
			.output_selector_dout	(output_selector)
		);
	reg [(2* `CHANNEL_WIDTH)-1:0] wordC_reg;
	reg [(2* `CHANNEL_WIDTH)-1:0] wordD_reg;
	always @(posedge clk)
		if (done_strobe_din)
			wordC_reg <= wordC_din;
	always @(posedge clk)
		if (done_strobe_din)
			wordD_reg <= wordD_din;
	always @(*)
		begin
			output_channel_dout = {`CHANNEL_WIDTH{1'b0}};
			case (output_selector)
				3'b101: output_channel_dout = shifted_header_din;
				3'b100:	output_channel_dout = wordC_reg[`CHANNEL_WIDTH-1:0];						
				3'b011:	output_channel_dout = wordC_reg[(2 * `CHANNEL_WIDTH)-1:`CHANNEL_WIDTH];		
				3'b010: output_channel_dout = wordD_reg[`CHANNEL_WIDTH-1:0];						
				3'b001: output_channel_dout = wordD_reg[(2 * `CHANNEL_WIDTH)-1:`CHANNEL_WIDTH];		
				3'b000: output_channel_dout = {`CHANNEL_WIDTH{1'b0}};
			endcase
		end
endmodule