module
   input          etx_ack; 
   reg            ready; 
   reg 		  etx_write; 
   reg [1:0] 	  etx_datamode; 
   reg [3:0] 	  etx_ctrlmode; 
   reg [31:0] 	  etx_dstaddr; 
   reg [31:0] 	  etx_srcaddr; 
   reg [31:0] 	  etx_data; 
   wire 	  rr_ready; 
   wire 	  rq_ready; 
   wire 	  wr_ready; 
   wire           emrr_rd_en; 
   wire 	  emwr_rd_en; 