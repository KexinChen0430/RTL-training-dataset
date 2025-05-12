module musb_hazard_unit(
    input   [4:0]   id_rs,                  
    input   [4:0]   id_rt,                  
    input   [4:0]   ex_rs,                  
    input   [4:0]   ex_rt,                  
    input           id_mtc0,                
    input   [4:0]   ex_gpr_wa,              
    input   [4:0]   mem_gpr_wa,             
    input   [4:0]   wb_gpr_wa,              
    input           id_branch,              
    input           id_jump,                
    input           ex_mem_to_gpr,          
    input           mem_mem_to_gpr,         
    input           ex_gpr_we,              
    input           mem_gpr_we,             
    input           wb_gpr_we,              
    input           ex_request_stall,       
    input           dmem_request_stall,     
    input           imem_request_stall,     
    input           if_exception_stall,     
    input           id_exception_stall,     
    input           ex_exception_stall,     
    input           mem_exception_stall,    
    output  [1:0]   forward_id_rs,          
    output  [1:0]   forward_id_rt,          
    output  [1:0]   forward_ex_rs,          
    output  [1:0]   forward_ex_rt,          
    output          if_stall,               
    output          id_stall,               
    output          ex_stall,               
    output          ex_stall_unit,          
    output          mem_stall,              
    output          wb_stall                
    );
    wire id_rs_is_zero;
    wire id_rt_is_zero;
    wire ex_rs_is_zero;
    wire ex_rt_is_zero;
    wire id_ex_rt_match_mtc0;
    wire id_ex_rt_match;
    wire id_ex_rs_match;
    wire id_mem_rs_match;
    wire id_mem_rt_match;
    wire id_wb_rs_match;
    wire id_wb_rt_match;
    wire ex_mem_rs_match;
    wire ex_mem_rt_match;
    wire ex_wb_rs_match;
    wire ex_wb_rt_match;
    wire stall_id_rs_mtc0;
    wire stall_id_rs_rt_load_ex;
    wire stall_id_rs_rt_branch;
    wire stall_id_rs_rt_load_mem;
    wire stall_ex_rs_rt_load_mem;
    wire forward_mem_id_rs;
    wire forward_mem_id_rt;
    wire forward_wb_id_rs;
    wire forward_wb_id_rt;
    wire forward_mem_ex_rs;
    wire forward_mem_ex_rt;
    wire forward_wb_ex_rs;
    wire forward_wb_ex_rt;
    assign id_rs_is_zero        = (id_rs == 5'b0);
    assign id_rt_is_zero        = (id_rt == 5'b0);
    assign ex_rs_is_zero        = (ex_rs == 5'b0);
    assign ex_rt_is_zero        = (ex_rt == 5'b0);
    assign id_ex_rt_match_mtc0  = (~id_rt_is_zero) & (id_rt == ex_gpr_wa)  & id_mtc0;           
    assign id_ex_rs_match       = (~id_rs_is_zero) & (id_rs == ex_gpr_wa)  & ex_gpr_we;         
    assign id_ex_rt_match       = (~id_rt_is_zero) & (id_rt == ex_gpr_wa)  & ex_gpr_we;         
    assign id_mem_rs_match      = (~id_rs_is_zero) & (id_rs == mem_gpr_wa) & mem_gpr_we;        
    assign id_mem_rt_match      = (~id_rt_is_zero) & (id_rt == mem_gpr_wa) & mem_gpr_we;        
    assign id_wb_rs_match       = (~id_rs_is_zero) & (id_rs == wb_gpr_wa)  & wb_gpr_we;         
    assign id_wb_rt_match       = (~id_rt_is_zero) & (id_rt == wb_gpr_wa)  & wb_gpr_we;         
    assign ex_mem_rs_match      = (~ex_rs_is_zero) & (ex_rs == mem_gpr_wa) & mem_gpr_we;        
    assign ex_mem_rt_match      = (~ex_rt_is_zero) & (ex_rt == mem_gpr_wa) & mem_gpr_we;        
    assign ex_wb_rs_match       = (~ex_rs_is_zero) & (ex_rs == wb_gpr_wa)  & wb_gpr_we;         
    assign ex_wb_rt_match       = (~ex_rt_is_zero) & (ex_rt == wb_gpr_wa)  & wb_gpr_we;         
    assign stall_id_rs_mtc0        = id_ex_rt_match_mtc0;
    assign stall_id_rs_rt_load_ex  = (id_ex_rs_match  | id_ex_rt_match)  & ex_mem_to_gpr  & id_branch;
    assign stall_id_rs_rt_branch   = (id_ex_rs_match  | id_ex_rt_match)  & id_branch;
    assign stall_id_rs_rt_load_mem = (id_mem_rs_match | id_mem_rt_match) & mem_mem_to_gpr & id_branch;
    assign stall_ex_rs_rt_load_mem = (ex_mem_rs_match | ex_mem_rt_match) & mem_mem_to_gpr;
    assign forward_mem_id_rs    = id_mem_rs_match & (~mem_mem_to_gpr);                          
    assign forward_mem_id_rt    = id_mem_rt_match & (~mem_mem_to_gpr);                          
    assign forward_wb_id_rs     = id_wb_rs_match;
    assign forward_wb_id_rt     = id_wb_rt_match;
    assign forward_mem_ex_rs    = ex_mem_rs_match & (~mem_mem_to_gpr);                          
    assign forward_mem_ex_rt    = ex_mem_rt_match & (~mem_mem_to_gpr);                          
    assign forward_wb_ex_rs     = ex_wb_rs_match;
    assign forward_wb_ex_rt     = ex_wb_rt_match;
    assign wb_stall         = mem_stall;
    assign mem_stall        = dmem_request_stall | mem_exception_stall;
    assign ex_stall_unit    = mem_stall | stall_ex_rs_rt_load_mem | ex_exception_stall;
    assign ex_stall         = ex_stall_unit | ex_request_stall;
    assign id_stall         = ex_stall  | stall_id_rs_mtc0 | stall_id_rs_rt_load_ex | stall_id_rs_rt_branch | stall_id_rs_rt_load_mem |
                              id_exception_stall | (if_stall & (id_branch | id_jump));
    assign if_stall         = imem_request_stall | if_exception_stall;                 
    assign forward_id_rs = (forward_mem_id_rs) ? 2'b01 : ((forward_wb_id_rs) ? 2'b10 : 2'b00);
    assign forward_id_rt = (forward_mem_id_rt) ? 2'b01 : ((forward_wb_id_rt) ? 2'b10 : 2'b00);
    assign forward_ex_rs = (forward_mem_ex_rs) ? 2'b01 : ((forward_wb_ex_rs) ? 2'b10 : 2'b00);
    assign forward_ex_rt = (forward_mem_ex_rt) ? 2'b01 : ((forward_wb_ex_rt) ? 2'b10 : 2'b00);
endmodule