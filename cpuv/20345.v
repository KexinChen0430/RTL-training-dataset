module NIOS_SYSTEMV3_NIOS_CPU_nios2_oci_xbrk (
  input            D_valid,          
  input            E_valid,          
  input   [ 19: 0] F_pc,             
  input            clk,              
  input            reset_n,          
  input            trigger_state_0,  
  input            trigger_state_1,  
  input   [  7: 0] xbrk_ctrl0,       
  input   [  7: 0] xbrk_ctrl1,       
  input   [  7: 0] xbrk_ctrl2,       
  input   [  7: 0] xbrk_ctrl3,       
  output           xbrk_break,       
  output           xbrk_goto0,       
  output           xbrk_goto1,       
  output           xbrk_traceoff,    
  output           xbrk_traceon,     
  output           xbrk_trigout      
);
wire             D_cpu_addr_en;      
wire             E_cpu_addr_en;      
reg              E_xbrk_goto0;       
reg              E_xbrk_goto1;       
reg              E_xbrk_traceoff;    
reg              E_xbrk_traceon;     
reg              E_xbrk_trigout;     
wire    [ 21: 0] cpu_i_address;      
wire             xbrk0_armed;        
wire             xbrk0_break_hit;    
wire             xbrk0_goto0_hit;    
wire             xbrk0_goto1_hit;    
wire             xbrk0_toff_hit;     
wire             xbrk0_ton_hit;      
wire             xbrk0_tout_hit;     
reg              xbrk_break;         
wire             xbrk_break_hit;     
wire             xbrk_goto0;         
wire             xbrk_goto1;         
wire             xbrk_toff_hit;      
wire             xbrk_ton_hit;       
wire             xbrk_tout_hit;      
wire             xbrk_traceoff;      
wire             xbrk_traceon;       
wire             xbrk_trigout;       
endmodule