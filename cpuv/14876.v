module intr_controller( 
	clk, 
	nrst, 
	i_intr_vec, 
	o_intr, 
	i_MAddr, 
	i_MCmd, 
	i_MData, 
	i_MByteEn, 
	o_SCmdAccept, 
	o_SData, 
	o_SResp 
);
localparam [`ADDR_WIDTH-1:0] ISTATREG = 32'h000;	
localparam [`ADDR_WIDTH-1:0] IMASKREG = 32'h004;	
localparam [`ADDR_WIDTH-1:0] IRAWREG  = 32'h008;	
input wire			clk; 
input wire			nrst; 
input wire [31:0]		i_intr_vec; 
output wire			o_intr; 
input wire [`ADDR_WIDTH-1:0]	i_MAddr; 
input wire [2:0]		i_MCmd; 
input wire [`DATA_WIDTH-1:0]	i_MData; 
input wire [`BEN_WIDTH-1:0]	i_MByteEn; 
output wire			o_SCmdAccept; 
output reg [`DATA_WIDTH-1:0]	o_SData; 
output reg [1:0]		o_SResp; 
reg [31:0] int_mask;	
reg [31:0] raw_int;	
reg iack;		
reg [31:0] iack_mask;	
assign o_SCmdAccept = 1'b1;	
always @(*) 
begin
	case(i_MCmd) 
	`OCP_CMD_WRITE: begin 
		o_SData = {(`DATA_WIDTH){1'b0}}; 
		o_SResp = `OCP_RESP_DVA; 
	end
	`OCP_CMD_READ: begin 
		if(i_MAddr == ISTATREG) 
		begin
			o_SData = { {(`DATA_WIDTH-32){1'b0}},
				int_mask & raw_int }; 
		end
		else if(i_MAddr == IMASKREG) 
		begin
			o_SData = { {(`DATA_WIDTH-32){1'b0}}, int_mask }; 
		end
		else if(i_MAddr == IRAWREG) 
		begin
			o_SData = { {(`DATA_WIDTH-32){1'b0}}, raw_int }; 
		end
		else
			o_SData = 32'hDEADDEAD; 
		o_SResp = `OCP_RESP_DVA; 
	end
	default: begin 
		o_SData = {(`DATA_WIDTH){1'b0}}; 
		o_SResp = `OCP_RESP_NULL; 
	end
	endcase
end
always @(posedge clk or negedge nrst) 
begin
	if(!nrst) 
	begin
		int_mask <= 32'b0; 
		iack <= 1'b0; 
		iack_mask <= 32'b0; 
	end
	else if(i_MCmd == `OCP_CMD_WRITE) 
	begin
		iack <= i_MAddr == ISTATREG ? 1'b1 : 1'b0; 
		if(i_MAddr == ISTATREG) 
		begin
			iack_mask <= i_MData[31:0]; 
		end
		if(i_MAddr == IMASKREG) 
		begin
			int_mask <= i_MData[31:0]; 
		end
	end else
		iack <= 1'b0; 
end
assign o_intr = |(int_mask & raw_int); 
always @(posedge clk or negedge nrst) 
begin
	if(!nrst) 
	begin
		raw_int <= 32'b0; 
	end
	else
	begin
		raw_int <= (iack ? raw_int & ~iack_mask : raw_int) | i_intr_vec; 
	end
end
endmodule