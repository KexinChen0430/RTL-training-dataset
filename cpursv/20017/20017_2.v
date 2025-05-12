
module soc_design_General_DMA_mem_write(input  d1_enabled_write_endofpacket,
                                        input  fifo_datavalid,
                                        input  write_waitrequest,
                                        output fifo_read,
                                        output inc_write,
                                        output mem_write_n,
                                        output write_select);

  wire fifo_read;
  wire inc_write;
  wire mem_write_n;
  wire write_select;

  assign write_select = fifo_datavalid & ~d1_enabled_write_endofpacket;
  assign mem_write_n = ~write_select;
  assign fifo_read = ~write_waitrequest & write_select;
  assign inc_write = fifo_read;
endmodule

