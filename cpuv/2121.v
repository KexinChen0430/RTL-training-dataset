module data_vio
  (
    control,    
    clk,        
    async_in,   
    async_out,  
    sync_in,    
    sync_out    
  );
  inout  [35:0] control;  
  input         clk;      
  input  [31:0] async_in; 
  output [31:0] async_out;
  input  [31:0] sync_in;  
  output [31:0] sync_out; 
endmodule 