module RegFileWriteControl (
	input  [   `EX_STATE_BITS-1:0] executeState      , 
	input  [  `ALU_DATA_WIDTH-1:0] aluResultIn       , 
	input  [      `DATA_WIDTH-1:0] wRIn              , 
	input                    [5:0] IR                , 
	input  [      `DATA_WIDTH-1:0] gprStatusIn       , 
	inout  [`ALU_STATUS_WIDTH-1:0] aluStatusIn       , 
	output [                  2:0] writeCommand      , 
	output [      `DATA_WIDTH-1:0] gprWriteDataOut   , 
	output [      `DATA_WIDTH-1:0] statusWriteDataOut  
);
reg gprwriteQ4En;
reg [`DATA_WIDTH-1:0] gprwriteData;
assign gprWriteDataOut = gprwriteData;
always @(*) begin
	case (executeState)
		`EX_Q2: begin 
			gprwriteQ4En = 1'b0; 
			gprwriteData = {3'b000, IR[4:0]}; 
		end
		`EX_Q4_CLRF: begin 
			gprwriteQ4En = 1'b1; 
			gprwriteData = 8'd0; 
		end
		`EX_Q4_MOVWF: begin 
			gprwriteQ4En = 1'b1; 
			gprwriteData = wRIn; 
		end
		`EX_Q4_BXF: begin 
			gprwriteQ4En = 1'b1; 
			gprwriteData = aluResultIn; 
		end
		`EX_Q4_FSZ,`EX_Q4_ELSE: begin 
			if(IR[5]) begin 
				gprwriteQ4En = 1'b1; 
				gprwriteData = aluResultIn; 
			end
			else begin 
				gprwriteQ4En = 1'b0; 
				gprwriteData = 8'b0; 
			end
		end
		default: begin 
			gprwriteQ4En = 1'b0; 
			gprwriteData = 8'b0; 
		end
	endcase
end
reg writeStatusEn;
reg [`DATA_WIDTH-1:0] statusWriteData;
assign statusWriteDataOut = statusWriteData;
always @(*) begin
	case (executeState)
		`EX_Q4_CLRF,`EX_Q4_CLRW: begin 
			writeStatusEn = 1'b1; 
			statusWriteData = {gprStatusIn[7:3], 1'b1, gprStatusIn[1:0]}; 
		end
		`EX_Q4_ALUXLW,
		`EX_Q4_MOVF,
		`EX_Q4_ELSE: begin 
			writeStatusEn = 1'b1; 
			statusWriteData = {gprStatusIn[7:3], aluStatusIn}; 
		end
		default: begin 
			writeStatusEn = 1'b0; 
			statusWriteData = 8'b0; 
		end
	endcase
end
assign writeCommand = {executeState == `EX_Q2, 
	                       gprwriteQ4En, 
	                       writeStatusEn};  
endmodule