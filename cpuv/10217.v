module PC (
	input                          clk         , 
	input                          rst_n       , 
	input  [                  8:0] IR          , 
	input  [   `EX_STATE_BITS-1:0] executeState, 
	input  [   `FE_STATE_BITS-1:0] fetchState  , 
	input  [`ALU_STATUS_WIDTH-1:0] aluStatusIn , 
	input  [      `DATA_WIDTH-1:0] gprIn       , 
	input  [        `PC_WIDTH-1:0] stackIn     , 
	input  [                  2:0] writeCommand, 
	input  [                  4:0] gprFSRIn    , 
	output [        `PC_WIDTH-1:0] PC          , 
	output                         goto        , 
	output                         skip        
);
reg[`PC_WIDTH-1:0] rPC; 
reg rgoto; 
reg rskip; 
assign PC = rPC;
assign goto = rgoto;
assign skip = rskip;
always @(posedge clk) begin
		if (!rst_n) begin 
			rPC <= `PC_WIDTH'b0; 
			rskip <= 1'b0; 
			rgoto <= 1'b0; 
		end
		else begin 
			case (fetchState) 
				`FE_Q1: begin 
					if (!rgoto) begin 
						rPC <= rPC + 1'b1; 
					end
				end
			endcase
			case (executeState) 
				`EX_Q1: begin 
					if (rskip | rgoto) begin 
						rskip <= 1'b0; 
						rgoto <= 1'b0; 
					end
				end
			endcase
			if (writeCommand[1] && (gprFSRIn[4:0] == `ADDR_PCL)) begin 
				rPC <= {1'b0, IR[7:0]}; 
				rskip <= 1'b1; 
			end
		end
	end
endmodule