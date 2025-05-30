module ForwardControl ( 
	input						rst, 
	input[`RegAddrWidth-1:0]	reg_data_1_addr_ID, 
	input[`RegAddrWidth-1:0]	reg_data_2_addr_ID, 
	input[`RegAddrWidth-1:0]	reg_data_1_addr_EX, 
	input[`RegAddrWidth-1:0]	reg_data_2_addr_EX, 
	input[`RegAddrWidth-1:0]	target_EX, 
	input						WriteReg_EX, 
	input[`RegAddrWidth-1:0]	reg_data_2_addr_MEM, 
	input[`RegAddrWidth-1:0]	target_MEM, 
	input						WriteReg_MEM, 
	input						MemOrAlu_MEM, 
	input						we_hi_MEM, 
	input						we_lo_MEM, 
	input[`RegAddrWidth-1:0]	target_WB, 
	input						WriteReg_WB, 
	input						we_hi_WB, 
	input						we_lo_WB, 
	output reg[1:0]				FWA, 
	output reg[1:0]				FWB, 
	output reg[1:0]				FWhi, 
	output reg[1:0]				FWlo, 
	output reg					FWLS, 
	output reg[1:0]				FW_br_A, 
	output reg[1:0]				FW_br_B 
);
	always @(*) begin : proc_forwarding 
		if (rst == ~`RstEnable) begin 
			if ((reg_data_1_addr_ID == target_EX) && 
				(WriteReg_EX == `WriteEnable) && 
				(target_EX != 0)) begin 
				FW_br_A <= `FW_br_EX_ALU; 
			end
			else if ((reg_data_1_addr_ID == target_MEM) && 
					(WriteReg_MEM == `WriteEnable) && 
					(target_MEM != 0)) begin 
				case (MemOrAlu_MEM) 
					`ALU : FW_br_A <= `FW_br_MEM_ALU; 
					`Mem : FW_br_A <= `FW_br_MEM_MEM; 
					default : begin
					end
				endcase
			end
			else begin
				FW_br_A <= `FW_br_Origin; 
			end
			if ((reg_data_2_addr_ID == target_EX) && 
				(WriteReg_EX == `WriteEnable) && 
				(target_EX != 0)) begin 
					FW_br_B <= `FW_br_EX_ALU; 
			end
			else if ((reg_data_2_addr_ID == target_MEM) && 
				(WriteReg_MEM == `WriteEnable) && 
					(target_MEM != 0)) begin 
				case (MemOrAlu_MEM) 
					`ALU : FW_br_B <= `FW_br_MEM_ALU; 
					`Mem : FW_br_B <= `FW_br_MEM_MEM; 
					default : begin
					end
				endcase
			end
			else begin
				FW_br_B <= `FW_br_Origin; 
			end
			if ((reg_data_1_addr_EX == target_MEM) && 
				(WriteReg_MEM == `WriteEnable) && 
				(target_MEM != 0)) begin 
				FWA <= `FWMem; 
			end
			else if ((reg_data_1_addr_EX == target_WB) && 
				(WriteReg_WB == `WriteEnable) && 
				(target_WB != 0)) begin 
				FWA <= `FWWB; 
			end
			else begin
				FWA <= `FWOrigin; 
			end
			if ((reg_data_2_addr_EX == target_MEM) && 
				(WriteReg_MEM == `WriteEnable) && 
				(target_MEM != 0)) begin 
				FWB <= `FWMem; 
			end
			else if ((reg_data_2_addr_EX == target_WB) && 
				(WriteReg_WB == `WriteEnable) && 
				(target_WB != 0)) begin 
				FWB <= `FWWB; 
			end
			else begin
				FWB <= `FWOrigin; 
			end
			if (we_hi_MEM == `WriteEnable) begin 
				FWhi <= `FWMem; 
			end
			else if (we_hi_WB == `WriteEnable) begin 
				FWhi <= `FWWB; 
			end
			else begin
				FWhi <= `FWOrigin; 
			end
			if (we_lo_MEM == `WriteEnable) begin 
				FWlo <= `FWMem; 
			end
			else if (we_lo_WB == `WriteEnable) begin 
				FWlo <= `FWWB; 
			end
			else begin
				FWlo <= `FWOrigin; 
			end
			if ((reg_data_2_addr_MEM == target_WB) && 
				(WriteReg_WB == `WriteEnable) && 
				(target_WB != 0)) begin 
				FWLS <= `FW_LS_WB; 
			end
			else begin
				FWLS <= `FW_LS_Origin; 
			end
		end
		else begin 
			FWA			<= 0; 
			FWB			<= 0; 
			FWhi		<= 0; 
			FWlo		<= 0; 
			FWLS		<= 0; 
			FW_br_A		<= 0; 
			FW_br_B		<= 0; 
		end
	end
endmodule 