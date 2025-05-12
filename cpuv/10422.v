module bsg_fifo_bypass
 #(parameter `BSG_INV_PARAM(width_p ) 
   , parameter logic ready_THEN_valid_p = 0 
   )
  (input [width_p-1:0]          data_i  
   , input                      v_i     
   , output logic               ready_o 
   , output logic [width_p-1:0] data_o 
   , output logic               v_o    
   , input                      yumi_i 
   , output logic [width_p-1:0] fifo_data_o  
   , output logic               fifo_v_o     
   , input                      fifo_ready_i 
   , input [width_p-1:0]        fifo_data_i  
   , input                      fifo_v_i     
   , output                     fifo_yumi_o  
   );
  wire enq = ready_THEN_valid_p ? v_i : (ready_o & v_i); 
  assign ready_o     = fifo_ready_i; 
  assign fifo_data_o = data_i; 
  assign fifo_v_o    = enq & (fifo_v_i | ~yumi_i); 
  assign data_o      = fifo_v_i ? fifo_data_i : data_i; 
  assign v_o         = fifo_v_i | enq; 
  assign fifo_yumi_o = fifo_v_i & yumi_i; 
endmodule