module antares_ifid_register (
  input             clk,             
  input             rst,             
  input [31:0]      if_instruction,  
  input [31:0]      if_pc_add4,      
  input [31:0]      if_exception_pc, 
  input             if_is_bds,       
  input             if_flush,        
  input             if_stall,        
  input             id_stall,        
  output reg [31:0] id_instruction,  
  output reg [31:0] id_pc_add4,      
  output reg [31:0] id_exception_pc, 
  output reg        id_is_bds,       
  output reg        id_is_flushed    
  );