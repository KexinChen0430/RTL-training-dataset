module kpu_regs(
    input wire             clk_i,                 
    input wire             rst_i,                 
    input wire             hold_i,                
    input wire [`N-1:0]     pc_i,                 
    output reg [`N-1:0]     pc_o,                 
    input wire             sr_alu_wr,             
    input wire [3:0]        sr_alu_i,             
    input wire             sr_int_enable_wr,      
    input wire             sr_int_enable_i,       
    output reg [`N-1:0]     sr_o,                 
    input wire             reg_wr_en_i,           
    input wire [`N-1:0]     reg_wr_i,             
    input wire [`REG_NBIT-1:0] reg_wr_n_i,        
    input wire [`REG_NBIT-1:0] reg1_read_n_i,     
    output reg [`N-1:0]     reg1_read_o,          
    input wire [`REG_NBIT-1:0] reg2_read_n_i,     
    output reg [`N-1:0]     reg2_read_o,          
    input wire [`REG_NBIT-1:0] reg3_read_n_i,     
    output reg [`N-1:0]     reg3_read_o           
    );
    reg [`REG_N-1:0]        gen_reg[`N-1:0];       
    reg [3:0]               sr_alu_tmp;           
    reg                     sr_int_enable_tmp;    
    reg [`REG_N-1:0]        i;                    
    initial
        for (i = 0; i < `REG_N; i = i + 1)
            gen_reg[i]  = `N'h0;
    always @(posedge clk_i) begin
        if (rst_i) begin
            for (i = 0; i < `PC_N; i = i + 1)
                gen_reg[i] <= #1 `N'h0;
            gen_reg[`PC_N]     <= #1 `ROM_ADDR;
        end
        else if (!hold_i) begin
            gen_reg[`PC_N] <= #1 pc_i;
            if (reg_wr_en_i)
                gen_reg[reg_wr_n_i] <= #1 reg_wr_i;
            if (sr_alu_wr)
                gen_reg[`SR_N][3:0] <= #1 sr_alu_i;
            if (sr_int_enable_wr)
                gen_reg[`SR_N][4]  <= #1 sr_int_enable_i;
        end
    end
    always @(gen_reg[reg1_read_n_i] or reg1_read_n_i or reg_wr_en_i
         or reg_wr_i or reg_wr_n_i)
        if (reg_wr_en_i && reg1_read_n_i == reg_wr_n_i)
            reg1_read_o  = reg_wr_i;
        else
            reg1_read_o  = gen_reg[reg1_read_n_i];
    always @(gen_reg[reg2_read_n_i] or reg2_read_n_i or reg_wr_en_i
         or reg_wr_i or reg_wr_n_i)
        if (reg_wr_en_i && reg2_read_n_i == reg_wr_n_i)
            reg2_read_o  = reg_wr_i;
        else
            reg2_read_o  = gen_reg[reg2_read_n_i];
    always @(gen_reg[reg3_read_n_i] or reg3_read_n_i or reg_wr_en_i
         or reg_wr_i or reg_wr_n_i)
        if (reg_wr_en_i && reg3_read_n_i == reg_wr_n_i)
            reg3_read_o  = reg_wr_i;
        else
            reg3_read_o  = gen_reg[reg3_read_n_i];
    always @(gen_reg[`PC_N] or reg_wr_en_i or reg_wr_i
         or reg_wr_n_i)
        if (reg_wr_en_i && `PC_N == reg_wr_n_i)
            pc_o    = reg_wr_i;
        else
            pc_o    = gen_reg[`PC_N];
    always @(gen_reg[`SR_N] or sr_alu_i or sr_alu_wr
         or sr_int_enable_i or sr_int_enable_wr) begin
        if (sr_alu_wr)
            sr_alu_tmp  = sr_alu_i;
        else
            sr_alu_tmp  = gen_reg[`SR_N][3:0];
        if (sr_int_enable_wr)
            sr_int_enable_tmp  = sr_int_enable_i;
        else
            sr_int_enable_tmp  = gen_reg[`SR_N][4];
        sr_o = (sr_int_enable_tmp << 4) | sr_alu_tmp;
    end 
endmodule