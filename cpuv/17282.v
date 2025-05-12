module link_txo_interface ( 
   txo_data, txo_frame, txo_wr_wait_int, txo_rd_wait_int,
   txo_lclk, reset, txo_wr_data_even, txo_wr_data_odd, txo_wr_frame,
   txo_wr_launch_req_tlc, txo_wr_rotate_dis, txo_rd_data_even,
   txo_rd_data_odd, txo_rd_frame, txo_rd_launch_req_tlc,
   txo_rd_rotate_dis
   );
   parameter LW  = `CFG_LW; 
   input          txo_lclk; 
   input 	  reset; 
   input [LW-1:0]  txo_wr_data_even; 
   input [LW-1:0]  txo_wr_data_odd;  
   input 	   txo_wr_frame;     
   input 	   txo_wr_launch_req_tlc; 
   input 	   txo_wr_rotate_dis; 
   input [LW-1:0]  txo_rd_data_even; 
   input [LW-1:0]  txo_rd_data_odd;  
   input 	   txo_rd_frame;     
   input 	   txo_rd_launch_req_tlc; 
   input 	   txo_rd_rotate_dis; 
   output [LW-1:0]  txo_data;      
   output 	    txo_frame;     
   output 	    txo_wr_wait_int; 
   output 	    txo_rd_wait_int; 
   reg [LW-1:0]   data_even_lsl;
   reg [LW-1:0]   data_even_lsh;
   reg [LW-1:0]   data_odd_lsl; 
   reg 		  txo_frame; 
   wire 	 txo_frame_in;   
   wire [LW-1:0] data_even_in;   
   wire [LW-1:0] data_odd_in;    
   wire [LW-1:0] txo_data;       
   assign txo_wr_wait_int = txo_rd_rotate_dis; 
   assign txo_rd_wait_int = txo_wr_launch_req_tlc & ~txo_rd_rotate_dis; 
   assign txo_frame_in = txo_wr_frame | txo_rd_frame; 
   assign data_even_in[LW-1:0] = txo_wr_data_even[LW-1:0] |
				 txo_rd_data_even[LW-1:0]; 
   assign data_odd_in[LW-1:0] = txo_wr_data_odd[LW-1:0] |
				txo_rd_data_odd[LW-1:0]; 
   always @ (posedge txo_lclk or posedge reset) 
     if (reset)
       begin
	  txo_frame             <= 1'b0; 
	  data_even_lsl[LW-1:0] <= {(LW){1'b0}}; 
	  data_odd_lsl[LW-1:0]  <= {(LW){1'b0}}; 
       end
     else
       begin
	  txo_frame              <= txo_frame_in; 
 	  data_even_lsl[LW-1:0]  <= data_even_in[LW-1:0]; 
	  data_odd_lsl[LW-1:0]   <= data_odd_in[LW-1:0]; 
       end
   always @ (negedge txo_lclk or posedge reset) 
     if (reset)
       data_even_lsh[LW-1:0] <= {(LW){1'b0}}; 
     else
       data_even_lsh[LW-1:0]  <= data_even_lsl[LW-1:0]; 
   assign txo_data[LW-1:0] = txo_lclk ? data_even_lsh[LW-1:0]:
                                        data_odd_lsl[LW-1:0]; 
endmodule 