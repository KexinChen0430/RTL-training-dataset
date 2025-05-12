module switch_fabric
	(
		input wire clk, 
		input wire reset, 
		input wire [`CHANNEL_WIDTH-1:0]	inport_pe_din,
		input wire [`CHANNEL_WIDTH-1:0]	inport_xpos_din,
		input wire [`CHANNEL_WIDTH-1:0]	inport_ypos_din,
		input wire [`CHANNEL_WIDTH-1:0]	inport_xneg_din,
		input wire [`CHANNEL_WIDTH-1:0]	inport_yneg_din,
		input wire [3:0]				conf_pe_din,
		input wire [3:0]				conf_xpos_din,
		input wire [3:0]				conf_ypos_din,
		input wire [3:0]				conf_xneg_din,
		input wire [3:0]				conf_yneg_din,
		output reg [`CHANNEL_WIDTH-1:0]	outport_pe_dout,
		output reg [`CHANNEL_WIDTH-1:0]	outport_xpos_dout,
		output reg [`CHANNEL_WIDTH-1:0]	outport_ypos_dout,
		output reg [`CHANNEL_WIDTH-1:0]	outport_xneg_dout,
		output reg [`CHANNEL_WIDTH-1:0]	outport_yneg_dout
    );
localparam 	RQS0 =	4'b0001;
localparam	RQS1 =	4'b0010;
localparam	RQS2 =	4'b0100;
localparam	RQS3 =	4'b1000;
reg [`CHANNEL_WIDTH-1:0] output_pe;
always @(*)
	begin
		output_pe = {`CHANNEL_WIDTH{1'b0}};
		case (conf_pe_din)
			RQS0:	output_pe = inport_xpos_din;
			RQS1:	output_pe = inport_ypos_din;
			RQS2:	output_pe = inport_xneg_din;
			RQS3:	output_pe = inport_yneg_din;
		endcase 
	end
always @(posedge clk)
	if (reset)
		outport_pe_dout = {`CHANNEL_WIDTH{1'b0}};
	else
		outport_pe_dout = output_pe;
endmodule