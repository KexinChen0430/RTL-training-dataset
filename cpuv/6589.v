module memory #(
	parameter MEMWORDS = 1048576 
)
(
	clk,
	nrst,
	i_MAddr,
	i_MCmd,
	i_MData,
	i_MByteEn,
	o_SCmdAccept,
	o_SData,
	o_SResp
);
input wire			clk; 
input wire			nrst; 
input wire [`ADDR_WIDTH-1:0]	i_MAddr; 
input wire [2:0]		i_MCmd; 
input wire [`DATA_WIDTH-1:0]	i_MData; 
input wire [`BEN_WIDTH-1:0]	i_MByteEn; 
output wire			o_SCmdAccept; 
output reg [`DATA_WIDTH-1:0]	o_SData; 
output reg [1:0]		o_SResp; 
reg [`DATA_WIDTH-1:0] mem[0:MEMWORDS-1]; 
integer i; 
initial
begin : memory_init
`ifndef VERILATOR
	reg [65536*8-1:0] filepath; 
`else
	reg [256*8-1:0] filepath; 
`endif
	for(i=0; i<MEMWORDS; i=i+1) begin
		mem[i] = 0; 
	end
	if($value$plusargs("MEMORY_FILE=%s", filepath))
	begin
		$readmemh(filepath, mem); 
	end
	else
	begin
`ifdef MEMORY_IMAGE
		$readmemh(`MEMORY_IMAGE, mem); 
`endif
	end
end
assign o_SCmdAccept = 1'b1; 
always @(posedge clk or negedge nrst)
begin
	if(!nrst)
	begin
		o_SData <= { (`DATA_WIDTH){1'b0} }; 
		o_SResp <= `OCP_RESP_NULL; 
	end
	else
	begin
		case(i_MCmd) 
		`OCP_CMD_WRITE: begin 
			if(i_MAddr[`ADDR_WIDTH-1:2] < MEMWORDS) 
			begin
				if(i_MByteEn[0]) mem[i_MAddr[`ADDR_WIDTH-1:2]][7:0]   <= i_MData[7:0];
				if(i_MByteEn[1]) mem[i_MAddr[`ADDR_WIDTH-1:2]][15:8]  <= i_MData[15:8];
				if(i_MByteEn[2]) mem[i_MAddr[`ADDR_WIDTH-1:2]][23:16] <= i_MData[23:16];
				if(i_MByteEn[3]) mem[i_MAddr[`ADDR_WIDTH-1:2]][31:24] <= i_MData[31:24];
			end
			o_SResp <= `OCP_RESP_DVA; 
		end
		`OCP_CMD_READ: begin 
			if(i_MAddr[`ADDR_WIDTH-1:2] < MEMWORDS) 
			begin
				o_SData <= mem[i_MAddr[`ADDR_WIDTH-1:2]]; 
			end
			else
				o_SData <= 32'hDEADDEAD; 
			o_SResp <= `OCP_RESP_DVA; 
		end
		default: begin 
			o_SResp <= `OCP_RESP_NULL; 
		end
		endcase
	end
end
endmodule