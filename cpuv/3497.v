module pipeline_ctrl(
    clk, RST, 
    A_addr,   
    B_addr,   
    ctrl,     
    ctrl_p34, 
    ctrl_p45, 
    reg_en_p52, 
    reg_addr_p34,    
    reg_addr_p45,    
    reg_addr_p52,    
    reg_dataA_p2,    
    reg_dataB_p2,    
    reg_data_p34,    
    imm_data_p34,    
    reg_data_p45,    
    reg_data_p52,    
    muxA_data,       
    muxB_data        
);
`include "params_proc.v"
input clk, RST;
input [REG_ADDR_WIDTH-1:0] A_addr, B_addr;
input [CTRL_WIDTH-1:0] ctrl, ctrl_p34, ctrl_p45;
input reg_en_p52;
input [REG_ADDR_WIDTH-1:0] reg_addr_p34, reg_addr_p45, reg_addr_p52;
input signed [DATA_WIDTH-1:0] reg_dataA_p2, reg_dataB_p2, reg_data_p34, imm_data_p34, reg_data_p45, reg_data_p52;
output reg signed [DATA_WIDTH-1:0] muxA_data, muxB_data;
always @(*) begin
    muxA_data = reg_dataA_p2;
    muxB_data = reg_dataB_p2;
    if (ctrl_p34 == LW_IMM) begin
        muxA_data = imm_data_p34;
    end else if (A_addr == reg_addr_p34 && ctrl_p34 != NOP) begin
        muxA_data = reg_data_p34;
    end else if (A_addr == reg_addr_p45 && ctrl_p45 != NOP) begin
        muxA_data = reg_data_p45;
    end else if (A_addr == reg_addr_p52 && reg_en_p52 == 1) begin
        muxA_data = reg_data_p52;
    end
    if (B_addr == reg_addr_p34 && ctrl_p34 != NOP) begin
        muxB_data = reg_data_p34;
    end else if (B_addr == reg_addr_p45 && ctrl_p45 != NOP) begin
        muxB_data = reg_data_p45;
    end else if (B_addr == reg_addr_p52 && reg_en_p52 == 1) begin
        muxB_data = reg_data_p52;
    end
end
endmodule