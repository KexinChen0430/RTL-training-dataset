module jbi_snoop_out_queue (
  valid,
  enqueue, dequeue, clk, rst_l
  );
  `include "jbi_mout.h"
  input         enqueue;
  output        valid;
  input         dequeue;
  input         clk;
  input         rst_l;
  wire [15:0] next_counter;
  wire [15:0] counter;
  dffrle_ns #(JBI_SNOOP_OUT_QUEUE_SIZE) counter_reg (.din(next_counter), .en(counter_en), .q(counter), .rst_l(rst_l), .clk(clk));
  assign counter_en = enqueue ^ dequeue;
  assign next_counter = (enqueue)?   counter + 1'b1:
                       counter - 1'b1;
  assign valid = (counter != 1'b0);
  endmodule