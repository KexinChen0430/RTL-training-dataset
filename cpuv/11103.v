module altera_up_video_scaler_shrink (
	clk,
	reset,
	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_valid,
	stream_out_ready,
	stream_in_ready,
	stream_out_data,
	stream_out_startofpacket,
	stream_out_endofpacket,
	stream_out_valid
);
/*****************************************************************************
parameter DW					=  15; 
parameter WW					=   9; 
parameter HW					=   9; 
parameter WIDTH_IN			= 640; 
parameter WIDTH_DROP_MASK	= 4'b0101;
parameter HEIGHT_DROP_MASK	= 4'b0000;
/*****************************************************************************
input						clk;
input						reset;
input			[DW: 0]	stream_in_data;
input						stream_in_startofpacket;
input						stream_in_endofpacket;
input						stream_in_valid;
input						stream_out_ready;
output					stream_in_ready;
output reg	[DW: 0]	stream_out_data;
output reg				stream_out_startofpacket;
output reg				stream_out_endofpacket;
output reg				stream_out_valid;
/*****************************************************************************
/*****************************************************************************
wire 						drop;
wire						capture_inputs;
wire						transfer_data;
reg						saved_startofpacket;
reg			[DW: 0]	data;
reg						startofpacket;
reg						endofpacket;
reg						valid;
reg			[WW: 0]	width_counter;
reg			[HW: 0]	height_counter;
reg			[ 3: 0]	drop_pixel;
reg			[ 3: 0]	drop_line;
/*****************************************************************************
/*****************************************************************************
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data				<=  'h0;
		stream_out_startofpacket	<= 1'b0;
		stream_out_endofpacket		<= 1'b0;
		stream_out_valid				<= 1'b0;
	end
	else if (transfer_data)
	begin
		stream_out_data				<= data;
		stream_out_startofpacket	<= startofpacket;
		stream_out_endofpacket		<= endofpacket;
		stream_out_valid				<= valid;
	end
	else if (stream_out_ready & stream_out_valid)
	begin
		stream_out_data				<=  'h0;
		stream_out_startofpacket	<= 1'b0;
		stream_out_endofpacket		<= 1'b0;
		stream_out_valid				<= 1'b0;
	end
end
always @(posedge clk)
	if (reset)
		saved_startofpacket	<= 1'b0;
	else if (capture_inputs)
		saved_startofpacket	<= 1'b0;
	else if (stream_in_ready)
		saved_startofpacket	<= saved_startofpacket | stream_in_startofpacket;
always @(posedge clk)
begin
	if (reset)
	begin
		data				<=  'h0;
		startofpacket	<= 1'b0;
		endofpacket		<= 1'b0;
		valid				<= 1'b0;
	end
	else if (capture_inputs)
	begin
		data				<= stream_in_data;
		startofpacket	<= stream_in_startofpacket | saved_startofpacket;
		endofpacket		<= stream_in_endofpacket;
		valid				<= stream_in_valid;
	end
	else if (stream_in_ready)
		endofpacket		<= endofpacket | stream_in_endofpacket;
end
always @(posedge clk)
begin
	if (reset)
		width_counter		<= 'h0;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket | (width_counter == (WIDTH_IN - 1)))
			width_counter	<= 'h0;
		else
			width_counter	<= width_counter + 1;
	end
end
always @(posedge clk)
begin
	if (reset)
		height_counter		<= 'h0;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket)
			height_counter	<= 'h0;
		else if (width_counter == (WIDTH_IN - 1))
			height_counter	<= height_counter + 1;
	end
end
always @(posedge clk)
begin
	if (reset)
		drop_pixel		<= 4'b0000;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket)
			drop_pixel	<= WIDTH_DROP_MASK;
		else if (width_counter == (WIDTH_IN - 1))
			drop_pixel	<= WIDTH_DROP_MASK;
		else
			drop_pixel	<= {drop_pixel[2:0], drop_pixel[3]};
	end
end
always @(posedge clk)
begin
	if (reset)
		drop_line		<= 4'b0000;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket)
			drop_line	<= HEIGHT_DROP_MASK;
		else if (width_counter == (WIDTH_IN - 1))
			drop_line	<= {drop_line[2:0], drop_line[3]};
	end
end
/*****************************************************************************
assign stream_in_ready	= stream_in_valid & (drop | ~valid | transfer_data);
assign drop					= drop_pixel[0] | drop_line[0];
assign capture_inputs	= stream_in_ready & ~drop;
assign transfer_data		= ~stream_out_valid & stream_in_valid & ~drop;
/*****************************************************************************
endmodule