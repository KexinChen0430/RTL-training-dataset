module clip2 (
	val_in,
	val_out
);
parameter CLIP_WIDTH = 16;
input  signed [CLIP_WIDTH-1  :0] val_in;
output        [`PIXEL_WIDTH-1:0] val_out;
wire   signed [10-1          :0] val_tmp;
assign val_tmp = (val_in + 'd8224) >> 6;
assign val_out = ( val_tmp  < 0  ) ? 'd0   :
	         ( val_tmp  > 255) ? 'd255 :
		 val_tmp[`PIXEL_WIDTH-1:0];
endmodule