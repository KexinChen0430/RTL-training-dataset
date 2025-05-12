module stage2_decode(
    input clk_i,             
    input rst_i,             
    input [31:0] ir_i,       
    input [29:0] nextpc_i,   
    input stall_i,           
    input do_wb_i,           
    input [4:0] wb_reg_i,    
    input [31:0] wb_val_i,   
    output stall_o,                  
    output reg [1:0] control_branch_o, 
    output reg control_load_o,       
    output reg control_store_o,      
    output reg [3:0] aluop_o,        
    output reg [31:0] alu_a_o,       
    output reg [31:0] alu_b_o,       
    output [31:0] branch_test_val_o, 
    output reg do_wb_o,              
    output reg [4:0] wb_reg_o        
);
reg [31:0] ir;
reg [29:0] nextpc;
assign stall_o = stall_i;
always @(posedge clk_i)
begin
    if (rst_i) begin
        ir <= 0;         
        nextpc <= 0;     
    end else if (!stall_i) begin
        ir <= ir_i;      
        nextpc <= nextpc_i; 
    end
end
wire [1:0] decode_form = ir[31:30]; 
wire [3:0] decode_op = ir[29:26];   
wire [4:0] decode_rd = ir[25:21];   
wire [4:0] decode_ra = ir[20:16];   
wire [4:0] decode_rb = ir[15:11];   
wire [31:0] decode_imm16_signed = (ir[15]) ? { 16'b1111111111111111, ir[15:0] } : { 16'b0000000000000000, ir[15:0] };
wire [31:0] decode_imm21_signed = (ir[20]) ? { 11'b11111111111, ir[20:0] } : { 11'b00000000000, ir[20:0] };
wire [31:0] reg_a; 
wire [31:0] reg_b; 
reg [4:0] reg_b_sel; 
regfile_zero #(32, 5) regs(
    .clk(clk_i),
    .rst(rst_i),
    .we(do_wb_i),
    .wsel(wb_reg_i),
    .wdata(wb_val_i),
    .asel(decode_ra),
    .adata(reg_a),
    .bsel(reg_b_sel),
    .bdata(reg_b)
);
assign branch_test_val_o = reg_b;
always @(*) 
begin
    aluop_o = 4'bxxxx; 
    control_load_o = 0; 
    control_store_o = 0; 
    control_branch_o = `CONTROL_BRANCH_NOTAKE; 
    alu_a_o = reg_a; 
    alu_b_o = reg_b; 
    reg_b_sel = decode_rb; 
    do_wb_o = 0; 
    wb_reg_o = decode_rd; 
    casez (decode_form)
        2'b0?: begin 
            aluop_o = decode_op; 
            if (decode_form == 0) begin
                $display("form 0"); 
                alu_b_o = decode_imm16_signed; 
            end else begin
                $display("form 1"); 
            end
            case (decode_op)
                default: begin
                    if (wb_reg_o != 0) 
                        do_wb_o = 1; 
                end
                4'b1110: begin
                    $display("load"); 
                    control_load_o = 1; 
                end
                4'b1111: begin
                    $display("store"); 
                    control_store_o = 1; 
                end
            endcase
        end
        2'b10: begin 
            $display("form 2 - branch"); 
            if (ir[28] == 0) begin
                aluop_o = `ALU_OP_ADD; 
                alu_a_o = { 2'b0, nextpc }; 
                alu_b_o = decode_imm21_signed; 
                reg_b_sel = decode_rd; 
            end else begin
                aluop_o = `ALU_OP_LSR; 
                alu_b_o = 2; 
            end
            if (ir[26]) begin
                control_branch_o = `CONTROL_BRANCH_COND_Z; 
            end else begin
                control_branch_o = `CONTROL_BRANCH_COND_NZ; 
            end
            if (ir[27]) begin
                wb_reg_o = 31; 
                do_wb_o = 1; 
            end
        end
        2'b11: begin 
            $display("form 3 - undefined"); 
        end
    endcase
end
endmodule