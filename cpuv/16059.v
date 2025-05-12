module xfft_v7_1 (
  rfd,             
  start,           
  fwd_inv,         
  dv,              
  done,            
  clk,             
  busy,            
  scale_sch_we,    
  fwd_inv_we,      
  edone,           
  xn_re,           
  xk_im,           
  xn_index,        
  scale_sch,       
  xk_re,           
  xn_im,           
  xk_index         
); 
  output rfd;      
  input start;     
  input fwd_inv;   
  output dv;       
  output done;     
  input clk;       
  output busy;     
  input scale_sch_we; 
  input fwd_inv_we;   
  output edone;    
  input [15 : 0] xn_re; 
  output [15 : 0] xk_im; 
  output [11 : 0] xn_index; 
  input [11 : 0] scale_sch; 
  output [15 : 0] xk_re;    
  input [15 : 0] xn_im;     
  output [11 : 0] xk_index; 
endmodule 