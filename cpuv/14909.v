module sim_control(
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
localparam [`ADDR_WIDTH-1:0] CTRLREG = 32'h000;	
localparam [`ADDR_WIDTH-1:0] DELYREG = 32'h004;	
localparam [`ADDR_WIDTH-1:0] BUSEREG = 32'h008;	
input wire			clk;                
input wire			nrst;               
input wire [`ADDR_WIDTH-1:0]	i_MAddr;        
input wire [2:0]		i_MCmd;             
input wire [`DATA_WIDTH-1:0]	i_MData;        
input wire [`BEN_WIDTH-1:0]	i_MByteEn;      
output wire			o_SCmdAccept;       
output reg [`DATA_WIDTH-1:0]	o_SData;        
output reg [1:0]		o_SResp;            
reg [`DATA_WIDTH-1:0] last_value;	
reg [7:0] delay;			
reg [7:0] counter;			
assign o_SCmdAccept = (i_MCmd == `OCP_CMD_IDLE || counter == 8'h00) ? 1'b1 : 1'b0;
always @(posedge clk or negedge nrst)
begin
	if(!nrst) 
	begin
		o_SData <= { (`DATA_WIDTH){1'b0} }; 
		o_SResp <= `OCP_RESP_NULL;          
		delay <= 8'h00;                     
		counter <= 8'h00;                   
		last_value <= 32'h00;               
	end
	else if(counter == 8'h00) 
	begin
		case(i_MCmd) 
		`OCP_CMD_WRITE: begin 
			if(i_MAddr == CTRLREG) 
			begin
				last_value <= i_MData; 
				if(i_MData[0]) 
				begin
					if(i_MData[31]) 
						$display("SIMULATION TERMINATED WITH ERRORS!"); 
					else
						$display("SIMULATION SUCCESSFULLY TERMINATED!"); 
					$finish; 
				end
			end
			else if(i_MAddr == DELYREG) 
			begin
				delay <= i_MData[7:0]; 
			end
			if(i_MAddr == BUSEREG) 
				o_SResp <= `OCP_RESP_ERR; 
			else if(delay == 8'h00) 
				o_SResp <= `OCP_RESP_DVA; 
			else
				counter <= delay; 
		end
		`OCP_CMD_READ: begin 
			if(i_MAddr == CTRLREG) 
			begin
				o_SData <= last_value; 
			end
			else if(i_MAddr == DELYREG) 
			begin
				o_SData <= { 24'h0, delay }; 
			end
			else
				o_SData <= 32'hDEADDEAD; 
			if(i_MAddr == BUSEREG) 
				o_SResp <= `OCP_RESP_ERR; 
			else if(delay == 8'h00) 
				o_SResp <= `OCP_RESP_DVA; 
			else
				counter <= delay; 
		end
		default: begin 
			o_SData <= { (`DATA_WIDTH){1'b0} }; 
			o_SResp <= `OCP_RESP_NULL; 
		end
		endcase
	end
	else if(counter == 8'h01) 
	begin
		o_SResp <= `OCP_RESP_DVA; 
		counter <= 8'h00; 
	end
	else 
		counter <= counter - 1; 
end
endmodule