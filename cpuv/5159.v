module Raster_Laser_Projector_Video_In_video_rgb_resampler_0 (
	clk,
	reset,
	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_empty,
	stream_in_valid,
	stream_out_ready,
	stream_in_ready,
	stream_out_data,
	stream_out_startofpacket,
	stream_out_endofpacket,
	stream_out_empty,
	stream_out_valid
);
/*****************************************************************************
parameter IDW		= 23;
parameter ODW		= 7;
parameter IEW		= 1;
parameter OEW		= 0;
parameter ALPHA	= 10'h3FF;
/*****************************************************************************
input						clk;
input						reset;
input			[IDW:0]	stream_in_data;
input						stream_in_startofpacket;
input						stream_in_endofpacket;
input			[IEW:0]	stream_in_empty;
input						stream_in_valid;
input						stream_out_ready;
output					stream_in_ready;
output reg	[ODW:0]	stream_out_data;
output reg				stream_out_startofpacket;
output reg				stream_out_endofpacket;
output reg	[OEW:0]	stream_out_empty;
output reg				stream_out_valid;
/*****************************************************************************
/*****************************************************************************
wire		[ 9: 0]	r;
wire		[ 9: 0]	g;
wire		[ 9: 0]	b;
wire		[ 9: 0]	a;
wire		[11: 0]	average_color;
wire		[ODW:0]	converted_data;
/*****************************************************************************
/*****************************************************************************
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data				<=  'b0;
		stream_out_startofpacket	<= 1'b0;
		stream_out_endofpacket		<= 1'b0;
		stream_out_empty				<=  'b0;
		stream_out_valid				<= 1'b0;
	end
	else if (stream_out_ready | ~stream_out_valid)
	begin
		stream_out_data				<= converted_data;
		stream_out_startofpacket	<= stream_in_startofpacket;
		stream_out_endofpacket		<= stream_in_endofpacket;
		stream_out_empty				<= stream_in_empty;
		stream_out_valid				<= stream_in_valid;
	end
end
/*****************************************************************************
assign stream_in_ready = stream_out_ready | ~stream_out_valid;
assign r = {stream_in_data[23:16], stream_in_data[23:22]};
assign g = {stream_in_data[15: 8], stream_in_data[15:14]};
assign b = {stream_in_data[ 7: 0], stream_in_data[ 7: 6]};
assign a = ALPHA;
assign average_color = {2'h0, r} + {1'b0, g, 1'b0} + {2'h0, b};
assign converted_data[ 7: 0] = average_color[11:4];
/*****************************************************************************
endmodule