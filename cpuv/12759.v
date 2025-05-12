module sha512_w_mem(
  input wire            clk,        
  input wire            reset_n,    
  input wire [1023 : 0] block,      
  input wire            init,       
  input wire            next,       
  output wire [63 : 0]  w           
);