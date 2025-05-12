module gearbox_66_40 (
	input clk, 
	input sclr,	
	input [65:0] din, 
	output reg din_ack, 
	output reg din_pre_ack, 
	output reg din_pre2_ack, 
	output [39:0] dout 
);
reg [5:0] gbstate = 0 ;
reg [103:0] stor = 0 ;
assign dout = stor[39:0];
reg [65:0] din_r = 0;
always @(posedge clk) begin
	din_r <= din[65:0];
	gbstate <= (sclr | gbstate[5]) ? 6'h0 : (gbstate + 1'b1);
	if (gbstate[5]) begin
		stor <= {40'h0,stor[103:40]};
	end
	else begin
		case (gbstate[4:0])
		endcase
	end
end
wire [32:0] in_pattern = 33'b101011010110101101011010110101101;
always @(posedge clk) begin
	if (sclr) din_ack <= 1'b0;
	else din_ack <= (64'h0 | in_pattern) >> gbstate;
end
wire [32:0] in_pattern2 = 33'b110101101011010110101101011010110;
always @(posedge clk) begin
	if (sclr) din_pre_ack <= 1'b0;
	else din_pre_ack <= (64'h0 | in_pattern2) >> gbstate;
end
wire [32:0] in_pattern3 = 33'b011010110101101011010110101101011;
always @(posedge clk) begin
	if (sclr) din_pre2_ack <= 1'b0;
	else din_pre2_ack <= (64'h0 | in_pattern3) >> gbstate;
end
endmodule