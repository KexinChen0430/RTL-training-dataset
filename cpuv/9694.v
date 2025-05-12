module clip (  
	val_in,    
	val_out    
);
parameter CLIP_WIDTH = 16;  
input  [CLIP_WIDTH-1  :0] val_in;  
output [`PIXEL_WIDTH-1:0] val_out;  
assign val_out = ( val_in  < 0  ) ? 'd0   :
	         ( val_in  > 255) ? 'd255 :
		 val_in[`PIXEL_WIDTH-1:0];
endmodule  