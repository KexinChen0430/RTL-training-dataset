module link_txo_buffer(
   txo_data_even, txo_data_odd, txo_frame,
   c0_tran_frame_tlc, c0_tran_byte_even_tlc, c0_tran_byte_odd_tlc,
   c1_tran_frame_tlc, c1_tran_byte_even_tlc, c1_tran_byte_odd_tlc,
   c2_tran_frame_tlc, c2_tran_byte_even_tlc, c2_tran_byte_odd_tlc,
   c3_tran_frame_tlc, c3_tran_byte_even_tlc, c3_tran_byte_odd_tlc
   );
   parameter LW  = `CFG_LW;
   input          c0_tran_frame_tlc;      
   input [LW-1:0] c0_tran_byte_even_tlc;  
   input [LW-1:0] c0_tran_byte_odd_tlc;   
   input          c1_tran_frame_tlc;      
   input [LW-1:0] c1_tran_byte_even_tlc;  
   input [LW-1:0] c1_tran_byte_odd_tlc;   
   input          c2_tran_frame_tlc;      
   input [LW-1:0] c2_tran_byte_even_tlc;  
   input [LW-1:0] c2_tran_byte_odd_tlc;   
   input          c3_tran_frame_tlc;      
   input [LW-1:0] c3_tran_byte_even_tlc;  
   input [LW-1:0] c3_tran_byte_odd_tlc;   
   output [LW-1:0]  txo_data_even; 
   output [LW-1:0]  txo_data_odd;  
   output           txo_frame;     
   wire         txo_frame;     
   wire [LW-1:0] txo_data_even; 
   wire [LW-1:0] txo_data_odd;  
   assign txo_frame = c0_tran_frame_tlc;
   assign txo_data_even[LW-1:0] = c0_tran_byte_even_tlc[LW-1:0];
   assign txo_data_odd[LW-1:0] = c0_tran_byte_odd_tlc[LW-1:0];
endmodule