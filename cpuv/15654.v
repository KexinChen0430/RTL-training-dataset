module collision
(
	input 	clk,					
	input	reset,					
	input 	[8:1] reg_address_in,	
	input 	[15:0] data_in,			
	output	[15:0] data_out,		
	input	dblpf,					
	input	[5:0] bpldata,			
	input	[7:0] nsprite			
);
parameter CLXCON = 9'h098;			
parameter CLXDAT = 9'h00E;			
reg		[15:0] clxcon;			
reg		[14:0] clxdat;			
wire	[3:0] sprmatch;			
wire	oddmatch;				
wire	evenmatch;				
always @(posedge clk)
	if (reset) 
		clxcon <= 16'h0fff;
	else if (reg_address_in[8:1]==CLXCON[8:1]) 
		clxcon <= data_in; 
wire [5:0] bm;
assign bm = (bpldata[5:0] ^ ~clxcon[5:0]) | (~clxcon[11:6]); 
assign oddmatch = bm[4] & bm[2] & bm[0] & (dblpf | evenmatch);
assign evenmatch = bm[5] & bm[3] & bm[1];
assign sprmatch[0] = nsprite[0] | (nsprite[1] & clxcon[12]);
assign sprmatch[1] = nsprite[2] | (nsprite[3] & clxcon[13]);
assign sprmatch[2] = nsprite[4] | (nsprite[5] & clxcon[14]);
assign sprmatch[3] = nsprite[6] | (nsprite[7] & clxcon[15]);
wire [14:0] cl;
reg clxdat_read_del;
assign cl[0]  = evenmatch   & oddmatch;		
wire clxdat_read = (reg_address_in[8:1]==CLXDAT[8:1]); 
always @(posedge clk)
	clxdat_read_del <= clxdat_read;
always @(posedge clk)
	if (!clxdat_read & clxdat_read_del) 
		clxdat <= 0;
	else 
		clxdat <= clxdat[14:0] | cl[14:0];
assign data_out = reg_address_in[8:1]==CLXDAT[8:1] ? {1'b1,clxdat[14:0]} : 16'd0; 
endmodule