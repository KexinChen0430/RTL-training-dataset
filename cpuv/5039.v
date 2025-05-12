module control_unit(
    input clk,
    input rst_n,
    input [3:0] id_opcode,
    output reg cu_reg_load,          
    output reg cu_alu_sel_b,         
    output reg [10:0] cu_alu_opcode, 
    output reg cu_dm_wea,            
    output reg cu_reg_data_loc,      
    output reg [1:0] cu_branch       
);
parameter NOOP_i  = 4'b0000;
parameter CPY_i   = 4'b0001;
parameter ADD_i   = 4'b0010;
parameter SUB_i   = 4'b0011;
parameter MUL_i   = 4'b0100;
parameter AND_i   = 4'b0101;
parameter OR_i    = 4'b0110;
parameter NOT_i   = 4'b0111;
parameter XOR_i   = 4'b1000;
parameter LS_i    = 4'b1001;
parameter RS_i    = 4'b1010;
parameter BEQ_i   = 4'b1011;
parameter BNE_i   = 4'b1100;
parameter LD_i    = 4'b1101;
parameter STR_i   = 4'b1110;
parameter JMP_i   = 4'b1111;
parameter NOOP  = 11'b00000000001;
parameter CPY   = 11'b00000000010;
parameter ADD   = 11'b00000000100;
parameter SUB   = 11'b00000001000;
parameter MUL   = 11'b00000010000;
parameter AND   = 11'b00000100000;
parameter OR    = 11'b00001000000;
parameter NOT   = 11'b00010000000;
parameter XOR   = 11'b00100000000;
parameter LS    = 11'b01000000000;
parameter RS    = 11'b10000000000;
always@(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    cu_alu_opcode   <= NOOP;
    cu_reg_load     <= 1'b0;
    cu_reg_data_loc <= 1'b0;
    cu_branch       <= 2'b00;
    cu_dm_wea       <= 1'b0;
    cu_alu_sel_b    <= 1'b0;
  end else begin
    case(id_opcode)
    	NOOP_i: begin
    	  cu_alu_opcode   <= NOOP;
    	  cu_reg_load     <= 1'b0;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	CPY_i: begin
    	  cu_alu_opcode   <= CPY;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	ADD_i: begin
    	  cu_alu_opcode   <= ADD;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	SUB_i: begin
    	  cu_alu_opcode   <= SUB;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	MUL_i: begin
    	  cu_alu_opcode   <= MUL;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	AND_i: begin
    	  cu_alu_opcode   <= AND;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	OR_i: begin
    	  cu_alu_opcode   <= OR;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	NOT_i: begin
    	  cu_alu_opcode   <= NOT;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	XOR_i: begin
    	  cu_alu_opcode   <= XOR;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	LS_i: begin
    	  cu_alu_opcode   <= LS;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	RS_i: begin
    	  cu_alu_opcode   <= RS;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	BEQ_i: begin
    	  cu_alu_opcode   <= SUB;
    	  cu_reg_load     <= 1'b0;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b01;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	BNE_i: begin
    	  cu_alu_opcode   <= SUB;
    	  cu_reg_load     <= 1'b0;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b10;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    	LD_i: begin
    	  cu_alu_opcode   <= CPY;
    	  cu_reg_load     <= 1'b1;
    	  cu_reg_data_loc <= 1'b1;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b1;
    	end
    	STR_i: begin
    	  cu_alu_opcode   <= CPY;
    	  cu_reg_load     <= 1'b0;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b00;
    	  cu_dm_wea       <= 1'b1;
    	  cu_alu_sel_b    <= 1'b1;
    	end
    	JMP_i: begin
    	  cu_alu_opcode   <= NOOP;
    	  cu_reg_load     <= 1'b0;
    	  cu_reg_data_loc <= 1'b0;
    	  cu_branch       <= 2'b11;
    	  cu_dm_wea       <= 1'b0;
    	  cu_alu_sel_b    <= 1'b0;
    	end
    endcase
  end
end
endmodule