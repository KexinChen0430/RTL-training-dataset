
module fifo();

  input  clk;
  input  rst_n;
  output fifo_full_w;
  input  enqueue_w;
  input  [DATA_WIDTH-1:0] data_in_w;
  output data_valid_r;
  input  dequeue_w;
  input  [1:0] full_threshold;
  output [DATA_WIDTH-1:0] rdata_r;


endmodule

