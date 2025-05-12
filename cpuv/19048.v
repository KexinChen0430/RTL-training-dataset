module link_rxi_channel (
   fifo_full_rlc, rdmesh_tran_out, rdmesh_frame_out,
   reset, cclk, cclk_en, rxi_lclk, cfg_extcomp_dis,
   rxi_assembled_tran_rlc, fifo_access_rlc, rdmesh_wait_in
   );
   parameter LW    = `CFG_LW; 
   input             reset;   
   input 	     cclk;    
   input 	     cclk_en; 
   input 	     rxi_lclk;
   input 	     cfg_extcomp_dis; 
   input [14*LW-1:0] rxi_assembled_tran_rlc; 
   input 	     fifo_access_rlc;        
   input 	     rdmesh_wait_in; 
   output 	  fifo_full_rlc; 
   output [2*LW-1:0] rdmesh_tran_out;  
   output 	     rdmesh_frame_out; 
endmodule