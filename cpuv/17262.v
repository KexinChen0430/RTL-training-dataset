module outputs) 
wire check_next_dstaddr_tlc; 
wire [2*LW-1:0] fifo_out_tlc; 
wire frame_in; 
wire next_access_tlc; 
wire [3:0] next_ctrlmode_tlc; 
wire [1:0] next_datamode_tlc; 
wire [AW-1:0] next_dstaddr_tlc; 
wire next_write_tlc; 
wire [FAD:0] rd_read_tlc; 
wire [2*LW-1:0] tran_in; 
wire tran_written_tlc; 
wire wr_fifo_full; 
endmodule 