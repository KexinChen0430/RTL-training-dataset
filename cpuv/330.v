module pipe_fw_ctrl(
    input wire       wr_reg_3_i,    
    input wire       wr_reg_4_i,    
    input wire [`N-1:0] rs1_2_i,    
    input wire [`N-1:0] rs2_2_i,    
    input wire [`N-1:0] data_out_3_i, 
    input wire [`N-1:0] data_4_i,    
    input wire [4:0]   rs1_n_2_i,    
    input wire [4:0]   rs2_n_2_i,    
    input wire [4:0]   reg_wr_n_3_i, 
    input wire [4:0]   reg_wr_n_4_i, 
    output reg [`N-1:0] rs1_2_o,     
    output reg [`N-1:0] rs2_2_o      
);
always @(*) begin
    if (reg_wr_n_3_i == rs1_n_2_i && wr_reg_3_i == 1'b1)
        rs1_2_o  = data_out_3_i;
    else if (reg_wr_n_4_i == rs1_n_2_i && wr_reg_4_i == 1'b1)
        rs1_2_o  = data_4_i;
    else
        rs1_2_o  = rs1_2_i;
end
always @(*) begin
    if (reg_wr_n_3_i == rs2_n_2_i && wr_reg_3_i == 1'b1)
        rs2_2_o = data_out_3_i;
    else if (reg_wr_n_4_i == rs2_n_2_i && wr_reg_4_i == 1'b1)
        rs2_2_o      = data_4_i;
    else
        rs2_2_o  = rs2_2_i;
end
endmodule