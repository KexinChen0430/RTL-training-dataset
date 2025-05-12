module LcdController(rst_n, clk, trigger, ctl, dFlag, in_d, out_d, rs, rw, e, data, ret_data); 
input rst_n, clk, trigger; 
input [7:0] ctl, data; 
output reg rs, rw, e; 
output reg [7:0] ret_data; 
output reg dFlag; 
input [7:0] in_d; 
output reg [7:0] out_d; 
reg [4:0] tsp1; 
parameter minTsp1 = 30; 
reg [7:0] tpw; 
parameter minTpw = 150; 
reg [3:0] thd; 
parameter minThd = 20; 
reg [3:0] trest; 
parameter minTrest = 250; 
parameter sIdle = 4'b0000;
parameter sWriteSetup = 4'b0010;
parameter sWriteEnable = 4'b0011;
parameter sWriteDisable = 4'b0100;
parameter sWriteRelease = 4'b0101;
parameter sReadSetup = 4'b0110;
parameter sReadEnable = 4'b0111;
parameter sReadDisable = 4'b1000;
parameter sReadRelease = 4'b1001;
reg [3:0] nextState; 
reg [3:0] prevState; 
always @(posedge clk) 
begin
	if (rst_n) 
	begin
		case (prevState) 
		endcase
	end
end
always @(posedge clk) 
if (rst_n) 
begin
	case (prevState) 
	endcase
end
always @(posedge clk) 
begin
	if (~rst_n) 
		prevState <= sIdle; 
	else
		prevState <= nextState; 
end
endmodule