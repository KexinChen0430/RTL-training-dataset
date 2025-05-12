module ddr3_s4_uniphy_example_if0_p0_qsys_sequencer_cpu_inst_nios2_oci_xbrk (
  input            D_valid,          
  input            E_valid,          
  input   [ 14: 0] F_pc,             
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
wire    [ 16: 0] cpu_i_address;      
wire             xbrk0_armed;        
wire             xbrk0_break_hit;    
wire             xbrk0_goto0_hit;    
wire             xbrk0_goto1_hit;    
wire             xbrk0_toff_hit;     
wire             xbrk0_ton_hit;      
wire             xbrk0_tout_hit;     
wire             xbrk1_armed;        
wire             xbrk1_break_hit;    
wire             xbrk1_goto0_hit;    
wire             xbrk1_goto1_hit;    
wire             xbrk1_toff_hit;     
wire             xbrk1_ton_hit;      
wire             xbrk1_tout_hit;     
wire             xbrk2_armed;        
wire             xbrk2_break_hit;    
wire             xbrk2_goto0_hit;    
wire             xbrk2_goto1_hit;    
wire             xbrk2_toff_hit;     
wire             xbrk2_ton_hit;      
wire             xbrk2_tout_hit;     
wire             xbrk3_armed;        
wire             xbrk3_break_hit;    
wire             xbrk3_goto0_hit;    
wire             xbrk3_goto1_hit;    
wire             xbrk3_toff_hit;     
wire             xbrk3_ton_hit;      
wire             xbrk3_tout_hit;     
reg              xbrk_break;         
wire             xbrk_break_hit;     
wire             xbrk_goto0;         
wire             xbrk_goto0_hit;     
wire             xbrk_goto1;         
wire             xbrk_goto1_hit;     
wire             xbrk_toff_hit;      
wire             xbrk_ton_hit;       
wire             xbrk_tout_hit;      
wire             xbrk_traceoff;      
wire             xbrk_traceon;       
wire             xbrk_trigout;       
endmodule