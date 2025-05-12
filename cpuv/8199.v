module nukv_Feedback #( 
	parameter KEY_WIDTH = 128, 
	parameter META_WIDTH = 96 
	)
    (
	input wire         clk, 
	input wire         rst, 
	input  wire [KEY_WIDTH+META_WIDTH-1:0] fb_in_data, 
	input  wire         fb_in_valid, 
	output wire         fb_in_ready, 
	output  wire [KEY_WIDTH+META_WIDTH-1:0] fb_out_data, 
	output  wire         fb_out_valid, 
	input wire         fb_out_ready, 
	input  wire [KEY_WIDTH+META_WIDTH-1:0] reg_in_data, 
	input  wire         reg_in_valid, 
	output wire         reg_in_ready, 
	output  wire [KEY_WIDTH+META_WIDTH-1:0] reg_out_data, 
	output  wire         reg_out_valid, 
	input wire         reg_out_ready 
	);
endmodule 