module link_txo_channel (
   emesh_wait_out,          
   txo_launch_req_tlc,      
   txo_rotate_dis,          
   tran_frame_tlc,          
   tran_byte_even_tlc,      
   tran_byte_odd_tlc,       
   cclk,                    
   cclk_en,                 
   txo_lclk,                
   reset,                   
   txo_rd,                  
   txo_cid,                 
   cfg_burst_dis,           
   emesh_tran_in,           
   emesh_frame_in,          
   txo_launch_ack_tlc       
);
parameter AW   = `CFG_AW;  
parameter DW   = `CFG_DW;  
parameter LW   = `CFG_LW;  
parameter FW   = `CFG_NW*`CFG_LW; 
parameter FAD  = 5; 
input          cclk;     
input          cclk_en;  
input          txo_lclk; 
input          reset;    
input          txo_rd;   
input [1:0]    txo_cid;  
input          cfg_burst_dis; 
input [2*LW-1:0] emesh_tran_in;  
input            emesh_frame_in; 
input            txo_launch_ack_tlc;
output           emesh_wait_out; 
output           txo_launch_req_tlc; 
output           txo_rotate_dis; 
output           tran_frame_tlc;       
output [LW-1:0]  tran_byte_even_tlc;  
output [LW-1:0]  tran_byte_odd_tlc;   
endmodule