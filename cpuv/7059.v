module dbus2ocp2(
	clk,                
	nrst,               
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
input wire			clk;
input wire			nrst;
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
reg [`ADDR_WIDTH-1:0]	maddr_r;    
reg [2:0]		mcmd_r;     
reg [`DATA_WIDTH-1:0]	mdata_r;    
reg [`BEN_WIDTH-1:0]	mben_r;     
reg			naccept_r;  
wire [2:0]		ocp_cmd = (i_DCmd ? (i_DRnW ? `OCP_CMD_READ : `OCP_CMD_WRITE) :
				`OCP_CMD_IDLE);
always @(posedge clk or negedge nrst)
begin
	if(!nrst) 
	begin
		maddr_r <= { (`ADDR_WIDTH){1'b0} };
		mcmd_r <= `OCP_CMD_IDLE;
		mdata_r <= { (`DATA_WIDTH){1'b0} };
		mben_r <= { (`BEN_WIDTH){1'b0} };
		naccept_r <= 1'b0;
	end
	else if(i_DCmd && !i_SCmdAccept) 
	begin
		maddr_r <= i_DAddr;
		mcmd_r <= ocp_cmd;
		mben_r <= i_DBen;
		naccept_r <= 1'b1; 
		if(!i_DRnW) 
			mdata_r <= i_DData; 
	end
	else if(i_SCmdAccept) 
	begin
		naccept_r <= 1'b0; 
	end
end
always @(*)
begin
	o_MAddr = (!naccept_r ? i_DAddr : maddr_r);
	o_MCmd = (!naccept_r ? ocp_cmd : mcmd_r);
	o_MByteEn = (!naccept_r ? i_DBen : mben_r);
	o_MData = (!naccept_r ? i_DData : mdata_r);
	o_DData = i_SData;
	o_DRdy = (i_SResp != `OCP_RESP_NULL ? 1'b1 : 1'b0);
	o_DErr = (i_SResp == `OCP_RESP_ERR || i_SResp == `OCP_RESP_FAIL ? 1'b1 : 1'b0);
end
endmodule