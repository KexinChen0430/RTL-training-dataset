module ibus2ocp2(
	clk,
	nrst,
	i_IAddr,
	i_IRdC,
	o_IData,
	o_IRdy,
	o_IErr,
	o_MAddr,
	o_MCmd,
	o_MData,
	o_MByteEn,
	i_SCmdAccept,
	i_SData,
	i_SResp
);
input wire			clk;
input wire			nrst;
input wire [`ADDR_WIDTH-1:0]	i_IAddr;
input wire			i_IRdC;
output reg [`DATA_WIDTH-1:0]	o_IData;
output reg			o_IRdy;
output reg			o_IErr;
output reg [`ADDR_WIDTH-1:0]	o_MAddr;
output reg [2:0]		o_MCmd;
output reg [`DATA_WIDTH-1:0]	o_MData;	
output reg [`BEN_WIDTH-1:0]	o_MByteEn;
input wire			i_SCmdAccept;
input wire [`DATA_WIDTH-1:0]	i_SData;
input wire [1:0]		i_SResp;
reg [`ADDR_WIDTH-1:0]	maddr_r;
reg [2:0]		mcmd_r;
reg			naccept_r;
wire [2:0]		ocp_cmd = (i_IRdC ? `OCP_CMD_READ : `OCP_CMD_IDLE);
always @(posedge clk or negedge nrst)
begin
	if(!nrst)
	begin
		maddr_r <= { (`ADDR_WIDTH){1'b0} };
		mcmd_r <= `OCP_CMD_IDLE;
		naccept_r <= 1'b0;
	end
	else if(i_IRdC && !i_SCmdAccept)
	begin
		maddr_r <= i_IAddr;
		mcmd_r <= ocp_cmd;
		naccept_r <= 1'b1;
	end
	else if(i_SCmdAccept)
	begin
		naccept_r <= 1'b0;
	end
end
always @(*)
begin
	o_MAddr = (!naccept_r ? i_IAddr : maddr_r);
	o_MCmd = (!naccept_r ? ocp_cmd : mcmd_r);
	o_MData = {(`DATA_WIDTH){1'b0}};
	o_MByteEn = {(`BEN_WIDTH){1'b1}};
	o_IData = i_SData;
	o_IRdy = (i_SResp != `OCP_RESP_NULL ? 1'b1 : 1'b0);
	o_IErr = (i_SResp == `OCP_RESP_ERR || i_SResp == `OCP_RESP_FAIL ? 1'b1 : 1'b0);
end
endmodule