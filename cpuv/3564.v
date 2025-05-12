module k580wt57(
	input clk, 
	input ce, 
	input reset, 
	input[3:0] iaddr, 
	input[7:0] idata, 
	input[3:0] drq, 
	input iwe_n, 
	input ird_n, 
	input hlda, 
	output hrq, 
	output reg[3:0] dack, 
	output[7:0] odata, 
	output[15:0] oaddr, 
	output owe_n, 
	output ord_n, 
	output oiowe_n, 
	output oiord_n 
);
parameter ST_IDLE = 3'b000; 
parameter ST_WAIT = 3'b001; 
parameter ST_T1   = 3'b010; 
parameter ST_T2   = 3'b011; 
parameter ST_T3   = 3'b100; 
parameter ST_T4   = 3'b101; 
parameter ST_T5   = 3'b110; 
parameter ST_T6   = 3'b111; 
reg[2:0] state; 
reg[1:0] channel; 
reg[7:0] mode; 
reg[4:0] chstate; 
reg[15:0] chaddr[3:0]; 
reg[15:0] chtcnt[3:0]; 
reg ff,exiwe_n; 
assign hrq = state!=ST_IDLE;
assign odata = {3'b0,chstate};
assign oaddr = chaddr[channel];
assign owe_n = chtcnt[channel][14]==0 || state!=ST_T2;
assign ord_n = chtcnt[channel][15]==0 || (state!=ST_T1 && state!=ST_T2);
assign oiowe_n = chtcnt[channel][15]==0 || state!=ST_T2;
assign oiord_n = chtcnt[channel][14]==0 || (state!=ST_T1 && state!=ST_T2);
wire[3:0] mdrq = drq & mode[3:0];
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0; ff <= 0; mode <= 0; exiwe_n <= 1'b1;
		chstate <= 0; dack <= 0;
	end else begin
		exiwe_n <= iwe_n;
		if (iwe_n && ~exiwe_n) begin
		end
		if (ce) begin
		end
	end
end
endmodule