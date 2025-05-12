module bus_mux (
    imm_in, reg_source, a_mux, a_out, reg_target, b_mux, b_out,
    c_bus, c_memory, c_pc, c_pc_plus4, c_mux, reg_dest_out,
    branch_func, take_branch
);
input  [15:0] imm_in;          
input  [31:0] reg_source;      
input  [ 1:0] a_mux;           
input  [31:0] reg_target;      
input  [ 1:0] b_mux;           
input  [31:0] c_bus;           
input  [31:0] c_memory;        
input  [31:0] c_pc;            
input  [31:0] c_pc_plus4;      
input  [ 2:0] c_mux;           
input  [ 2:0] branch_func;     
output [31:0] a_out;           
output [31:0] b_out;           
output [31:0] reg_dest_out;    
output        take_branch;     
reg    [31:0] reg_dest_out;    
reg    [31:0] b_out;           
reg    [31:0] a_out;           
reg           take_branch;     
wire is_equal = (reg_source == reg_target) ? 1'b1 : 1'b0;
always @(reg_source or imm_in or a_mux or c_pc) begin
    case (a_mux) 
        `a_from_reg_source :
            begin
                a_out = reg_source; 
            end
        `a_from_imm10_6 :
            begin
                a_out[31:5] = 27'b0; 
                a_out[ 4:0] = imm_in[10:6]; 
            end
        default :
            begin
                a_out = c_pc; 
            end
    endcase
end
always @(reg_target or imm_in or b_mux) begin
    case (b_mux) 
        `b_from_reg_target :
            begin
                b_out = reg_target; 
            end
        `b_from_imm :
            begin
                b_out = {16'b0, imm_in}; 
            end
        `b_from_signed_imm :
            begin
                if (~imm_in[15]) begin
                    b_out[31:16] = 16'b0; 
                end else begin
                    b_out[31:16] = 16'b1111111111111111; 
                end
                b_out[15:0] = imm_in; 
            end
        default :
            begin
                if (~imm_in[15]) begin
                    b_out[31:18] = 14'b0; 
                end else begin
                    b_out[31:18] = 14'b11111111111111; 
                end
                b_out[17:0] = {imm_in, 2'b00}; 
            end
    endcase
end
always @(c_bus or c_memory or c_pc or c_pc_plus4 or imm_in or c_mux) begin
    case (c_mux) 
        `c_from_alu :
            begin
                reg_dest_out = c_bus;
            end
        `c_from_memory :
            begin
                reg_dest_out = c_memory;
            end
        `c_from_pc :
            begin
                reg_dest_out = {c_pc[31:3], 3'b000};
            end
        `c_from_pc_plus4 :
            begin
                reg_dest_out = c_pc_plus4;
            end
        `c_from_imm_shift16 :
            begin
                reg_dest_out = {imm_in, 16'b0};
            end
        default :
            begin
                reg_dest_out = c_bus; 
            end
    endcase
end
always @(branch_func or reg_source or is_equal) begin
    case (branch_func) 
        `branch_ltz : take_branch = reg_source[31]; 
        `branch_lez : take_branch = reg_source[31] | is_equal; 
        `branch_eq  : take_branch = is_equal; 
        `branch_ne  : take_branch = ~is_equal; 
        `branch_gez : take_branch = ~reg_source[31]; 
        `branch_gtz : take_branch = ~reg_source[31] & ~is_equal; 
        `branch_yes : take_branch = 1'b1; 
        default     : take_branch = 1'b0; 
    endcase
end
endmodule 