module de3d_tc_store
	(
	input		de_clk,		
	input		de_rstn,	
	input		tc_ack,		
	input	[3:0]	mipmap,		
	input	[209:0]	lod_2,		
	input	[17:0]	ul,		
	input	[17:0]	ur,		
	input	[17:0]	ll,		
	input	[17:0]	lr,		
	input		clamp_ul,	
	input		clamp_ll,	
	input		clamp_ur,	
	input		clamp_lr,	
	input	[2:0]	bpt,		
	input	[4:0]	tfmt,		
	input          pal_mode,	
	input	[3:0]	tc_op,		
	input	[11:0]	tptch,		
	input		exact,		
	output reg	[3:0]	mipmap_store,	
	output reg		clamp_ul_r,	
	output reg		clamp_ll_r,	
	output reg		clamp_ur_r,	
	output reg		clamp_lr_r,	
	output  [8:0]   ul_store_x,	
	output  [8:0]   ul_store_y,	
	output  [8:0]   ll_store_x,	
	output  [8:0]   ll_store_y,	
	output  [8:0]   ur_store_x,	
	output  [8:0]   ur_store_y,	
	output  [8:0]   lr_store_x,	
	output  [8:0]   lr_store_y,	
	output reg	[2:0]	bpt_r,		
	output reg	[4:0]	tfmt_r,	
	output reg             pal_mode_r,	
	output reg	     	exact_r,	
	output reg	[3:0]	tc_op_store,	
	output reg	[20:0]	tex_org,	
	output reg	[11:0]	tex_ptch	
	);
`include "define_3d.h"
reg	[11:0]	tex_ptch_r;
reg	[17:0]	ul_store;	
reg	[17:0]	ur_store;	
reg	[17:0]	ll_store;	
reg	[17:0]	lr_store;	
always @(posedge de_clk or negedge de_rstn)
	begin
  		if (!de_rstn) tc_op_store    <= 0;
  		else if (tc_ack) tc_op_store    <= tc_op;
  	end
always @(posedge de_clk or negedge de_rstn)
	begin
  		if (!de_rstn) mipmap_store    <= 0;
  		else if (tc_ack) mipmap_store    <= mipmap;
  	end
always @(posedge de_clk, negedge de_rstn)
	begin
	if (!de_rstn) begin
    		ul_store       	<= 18'h0;
    		ur_store       	<= 18'h0;
    		ll_store       	<= 18'h0;
    		lr_store       	<= 18'h0;
    		clamp_ur_r	<= 1'b0;
    		clamp_ul_r     	<= 1'b0;
    		clamp_lr_r  	<= 1'b0;
    		clamp_ll_r  	<= 1'b0;
    		bpt_r		<= 3'b000;
    		tfmt_r		<= 5'h0;
	        pal_mode_r            <= 1'b0;
    		exact_r		<= 1'b0;
		tex_org 	<= 21'h0;
	end
	else if (tc_ack)
		begin
    			ul_store       	<= ul;
    			ur_store       	<= ur;
    			ll_store       	<= ll;
    			lr_store       	<= lr;
    			clamp_ur_r	<= clamp_ur;
    			clamp_ul_r     	<= clamp_ul;
    			clamp_lr_r  	<= clamp_lr;
    			clamp_ll_r  	<= clamp_ll;
    			bpt_r		<= bpt;
    			tfmt_r		<= tfmt;
		        pal_mode_r            <= pal_mode;
    			exact_r		<= exact;
			case(mipmap)
			4'b0000:	tex_org <= lod_2`LOD_0;
			4'b0001:	tex_org <= lod_2`LOD_1;
			4'b0010:	tex_org <= lod_2`LOD_2;
			4'b0011:	tex_org <= lod_2`LOD_3;
			4'b0100:	tex_org <= lod_2`LOD_4;
			4'b0101:	tex_org <= lod_2`LOD_5;
			4'b0110:	tex_org <= lod_2`LOD_6;
			4'b0111:	tex_org <= lod_2`LOD_7;
			4'b1000:	tex_org <= lod_2`LOD_8;
			default:	tex_org <= lod_2`LOD_9;
			endcase
  		end
	end
assign ul_store_x = ul_store[17:9];
assign ul_store_y = ul_store[8:0];
assign ll_store_x = ll_store[17:9];
assign ll_store_y = ll_store[8:0];
assign ur_store_x = ur_store[17:9];
assign ur_store_y = ur_store[8:0];
assign lr_store_x = lr_store[17:9];
assign lr_store_y = lr_store[8:0];
always @(posedge de_clk) if(tc_ack) tex_ptch_r <= tptch;
always @* tex_ptch  = tex_ptch_r >> mipmap_store;
endmodule