module dbus2ocp(
	i_DAddr,
	i_DCmd,
	i_DRnW,
	i_DBen,
	i_DData,
	o_DData,
	o_DRdy,
	o_DErr,
	o_MAddr,
	o_MCmd,
	o_MData,
	o_MByteEn,
	i_SCmdAccept,
	i_SData,
	i_SResp
);
input wire [`ADDR_WIDTH-1:0]	i_DAddr;
input wire			i_DCmd;
input wire			i_DRnW;
input wire [`BEN_WIDTH-1:0]	i_DBen;
input wire [`DATA_WIDTH-1:0]	i_DData;
output reg [`DATA_WIDTH-1:0]	o_DData;
output reg			o_DRdy;
output reg			o_DErr;
output reg [`ADDR_WIDTH-1:0]	o_MAddr;
output reg [2:0]		o_MCmd;
output reg [`DATA_WIDTH-1:0]	o_MData;
output reg [`BEN_WIDTH-1:0]	o_MByteEn;
input wire			i_SCmdAccept;	
input wire [`DATA_WIDTH-1:0]	i_SData;
input wire [1:0]		i_SResp;
always @(*)
begin
	o_MAddr = i_DAddr;
	o_MCmd = (i_DCmd ? (i_DRnW ? `OCP_CMD_READ : `OCP_CMD_WRITE) : `OCP_CMD_IDLE);
	o_MByteEn = i_DBen;
	o_MData = i_DData;
	o_DData = i_SData;
	o_DRdy = (i_SResp != `OCP_RESP_NULL ? 1'b1 : 1'b0);
	o_DErr = (i_SResp == `OCP_RESP_ERR || i_SResp == `OCP_RESP_FAIL ? 1'b1 : 1'b0);
end
endmodule