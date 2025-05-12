module xilinx_ddr2_wb_if_cache_control 
  ( cache_line_addr_valid, cache_line_addr_hit,
    wb_req,
    cache_write,
    writeback_done, fill_done,
    sync_start, sync_done,
    start_writeback, start_fill,
    cache_line_validate, cache_line_invalidate,
    selected_cache_line, selected_cache_line_enc,
    wb_clk, wb_rst);
   parameter num_lines = 16; 
   parameter num_lines_log2 = 4; 
   input [num_lines-1:0] cache_line_addr_valid; 
   input [num_lines-1:0] cache_line_addr_hit; 
   input 		 wb_req; 
   input 		 cache_write; 
   input 		 writeback_done, fill_done; 
   input 		 sync_start; 
   output 		 sync_done; 
   output reg 		 start_writeback; 
   output reg 		 start_fill; 
   output reg [num_lines-1:0] cache_line_validate; 
   output reg [num_lines-1:0] cache_line_invalidate; 
   output [num_lines-1:0]     selected_cache_line; 
   output reg [num_lines_log2-1:0] selected_cache_line_enc; 
   input 			   wb_clk, wb_rst; 
   reg [num_lines-1:0] 		   lines_dirty; 
   reg [num_lines-1:0] 		   selected_cache_line_from_miss; 
   reg 				   selected_cache_line_new; 
   reg 				   invalidate_clean_line; 
   reg [num_lines-1:0] 		   selected_cache_line_r; 
   reg [num_lines-1:0] 		   selected_cache_line_r2; 
   reg 				   wb_req_r; 
   wire 			   wb_req_new; 
   reg 				   wb_req_new_r; 
   parameter sync_line_check_wait = 4; 
   reg [num_lines-1:0] 		   sync_line_counter; 
   reg 				   sync_doing; 
   reg [sync_line_check_wait-1:0]  sync_line_select_wait_counter_shr; 
   reg 				   sync_line_done; 
   wire 			   sync_writeback_line; 
endmodule