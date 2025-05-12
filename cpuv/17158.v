module
   input          emtx_ack; 
   wire           emm_tx_access; 
   wire           emm_tx_write; 
   wire [1:0]     emm_tx_datamode; 
   wire [3:0]     emm_tx_ctrlmode; 
   wire [31:0]    emm_tx_dstaddr; 
   wire [31:0]    emm_tx_srcaddr; 
   wire [31:0]    emm_tx_data; 
   reg            ready; 
   reg [102:0]    fifo_data; 
   wire           rr_ready = ~emrr_empty & ~emm_tx_wr_wait; 
   wire           rq_ready = ~emrq_empty & ~emm_tx_rd_wait & ~rr_ready; 
   wire           wr_ready = ~emwr_empty & ~emm_tx_wr_wait & ~rr_ready & ~rq_ready; 
   wire           emrr_rd_en = rr_ready & (~ready | emtx_ack); 
   wire           emrq_rd_en = rq_ready & (~ready | emtx_ack); 
   wire           emwr_rd_en = wr_ready & (~ready | emtx_ack); 
   always @ (posedge clock) begin 
      if( reset ) begin 
         ready     <= 1'b0; 
         fifo_data <= 'd0; 
      end else begin 
         if( emrr_rd_en ) begin 
            ready <= 1'b1; 
            fifo_data <= emrr_rd_data; 
         end else if( emrq_rd_en ) begin 
            ready <= 1'b1; 
            fifo_data <= emrq_rd_data; 
         end else if( emwr_rd_en ) begin 
            ready <= 1'b1; 
            fifo_data <= emwr_rd_data; 
         end else if( emtx_ack ) begin 
            ready <= 1'b0; 
         end
      end 
   end 
   assign emm_tx_access   = ready; 
   assign emm_tx_write    = fifo_data[102]; 
   assign emm_tx_datamode = fifo_data[101:100]; 
   assign emm_tx_ctrlmode = fifo_data[99:96]; 
   assign emm_tx_dstaddr  = fifo_data[95:64]; 
   assign emm_tx_srcaddr  = fifo_data[63:32]; 
   assign emm_tx_data     = fifo_data[31:0]; 
endmodule 