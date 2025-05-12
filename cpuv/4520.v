module musb_idex_register(
    input               clk,                    
    input               rst,                    
    input       [4:0]   id_alu_operation,       
    input       [31:0]  id_data_rs,             
    input       [31:0]  id_data_rt,             
    input               id_gpr_we,              
    input               id_mem_to_gpr_select,   
    input               id_mem_write,           
    input       [1:0]   id_alu_port_a_select,   
    input       [1:0]   id_alu_port_b_select,   
    input       [1:0]   id_gpr_wa_select,       
    input               id_mem_byte,            
    input               id_mem_halfword,        
    input               id_mem_data_sign_ext,   
    input       [4:0]   id_rs,                  
    input       [4:0]   id_rt,                  
    input               id_imm_sign_ext,        
    input       [15:0]  id_sign_imm16,          
    input       [31:0]  id_cp0_data,            
    input       [31:0]  id_exception_pc,        
    input               id_movn,
    input               id_movz,
    input               id_llsc,
    input               id_kernel_mode,
    input               id_is_bds,
    input               id_trap,
    input               id_trap_condition,
    input               id_ex_exception_source,
    input               id_mem_exception_source,
    input               id_flush,               
    input               id_stall,               
    input               ex_stall,               
    output  reg [4:0]   ex_alu_operation,       
    output  reg [31:0]  ex_data_rs,             
    output  reg [31:0]  ex_data_rt,             
    output  reg         ex_gpr_we,              
    output  reg         ex_mem_to_gpr_select,   
    output  reg         ex_mem_write,           
    output  reg [1:0]   ex_alu_port_a_select,   
    output  reg [1:0]   ex_alu_port_b_select,   
    output  reg [1:0]   ex_gpr_wa_select,       
    output  reg         ex_mem_byte,            
    output  reg         ex_mem_halfword,        
    output  reg         ex_mem_data_sign_ext,   
    output  reg [4:0]   ex_rs,                  
    output  reg [4:0]   ex_rt,                  
    output  reg [16:0]  ex_sign_imm16,          
    output  reg [31:0]  ex_cp0_data,
    output  reg [31:0]  ex_exception_pc,
    output  reg         ex_movn,
    output  reg         ex_movz,
    output  reg         ex_llsc,
    output  reg         ex_kernel_mode,
    output  reg         ex_is_bds,
    output  reg         ex_trap,
    output  reg         ex_trap_condition,
    output  reg         ex_ex_exception_source,
    output  reg         ex_mem_exception_source
    );
    wire [16:0] id_imm_extended = (id_imm_sign_ext) ? {id_sign_imm16[15], id_sign_imm16[15:0]} : {1'b0, id_sign_imm16};
    always @(posedge clk) begin
        ex_alu_operation        <= (rst) ? 5'b0  : ((ex_stall) ? ex_alu_operation        : ((id_stall | id_flush) ? 5'b0    : id_alu_operation));
        ex_data_rs              <= (rst) ? 32'b0 : ((ex_stall) ? ex_data_rs                                                 : id_data_rs);
        ex_data_rt              <= (rst) ? 32'b0 : ((ex_stall) ? ex_data_rt                                                 : id_data_rt);
        ex_gpr_we               <= (rst) ? 1'b0  : ((ex_stall) ? ex_gpr_we               : ((id_stall | id_flush) ? 1'b0    : id_gpr_we));
        ex_mem_to_gpr_select    <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_to_gpr_select    : ((id_stall | id_flush) ? 1'b0    : id_mem_to_gpr_select));
        ex_mem_write            <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_write            : ((id_stall | id_flush) ? 1'b0    : id_mem_write));
        ex_alu_port_a_select    <= (rst) ? 2'b0  : ((ex_stall) ? ex_alu_port_a_select                                       : id_alu_port_a_select);
        ex_alu_port_b_select    <= (rst) ? 2'b0  : ((ex_stall) ? ex_alu_port_b_select                                       : id_alu_port_b_select);
        ex_gpr_wa_select        <= (rst) ? 2'b0  : ((ex_stall) ? ex_gpr_wa_select                                           : id_gpr_wa_select);
        ex_mem_byte             <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_byte                                                : id_mem_byte);
        ex_mem_halfword         <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_halfword                                            : id_mem_halfword);
        ex_mem_data_sign_ext    <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_data_sign_ext                                       : id_mem_data_sign_ext);
        ex_rs                   <= (rst) ? 5'b0  : ((ex_stall) ? ex_rs                                                      : id_rs);
        ex_rt                   <= (rst) ? 5'b0  : ((ex_stall) ? ex_rt                                                      : id_rt);
        ex_sign_imm16           <= (rst) ? 17'b0 : ((ex_stall) ? ex_sign_imm16                                              : id_imm_extended);
        ex_cp0_data             <= (rst) ? 32'b0 : ((ex_stall) ? ex_cp0_data                                                : id_cp0_data);
        ex_exception_pc         <= (rst) ? 32'b0 : ((ex_stall) ? ex_exception_pc                                            : id_exception_pc);
        ex_movn                 <= (rst) ? 1'b0  : ((ex_stall) ? ex_movn                 : ((id_stall | id_flush) ? 1'b0    : id_movn));
        ex_movz                 <= (rst) ? 1'b0  : ((ex_stall) ? ex_movz                 : ((id_stall | id_flush) ? 1'b0    : id_movz));
        ex_llsc                 <= (rst) ? 1'b0  : ((ex_stall) ? ex_llsc                 : ((id_stall | id_flush) ? 1'b0    : id_llsc));
        ex_kernel_mode          <= (rst) ? 1'b0  : ((ex_stall) ? ex_kernel_mode                                             : id_kernel_mode);
        ex_is_bds               <= (rst) ? 1'b0  : ((ex_stall) ? ex_is_bds                                                  : id_is_bds);
        ex_trap                 <= (rst) ? 1'b0  : ((ex_stall) ? ex_trap                 : ((id_stall | id_flush) ? 1'b0    : id_trap));
        ex_trap_condition       <= (rst) ? 1'b0  : ((ex_stall) ? ex_trap_condition                                          : id_trap_condition);
        ex_ex_exception_source  <= (rst) ? 1'b0  : ((ex_stall) ? ex_ex_exception_source  : ((id_stall | id_flush) ? 1'b0    : id_ex_exception_source));
        ex_mem_exception_source <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_exception_source : ((id_stall | id_flush) ? 1'b0    : id_mem_exception_source));
    end
endmodule