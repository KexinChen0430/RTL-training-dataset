
module inst_memory_controll  #(parameter 
       DATA_WIDTH      = 32,
       DATA_ADDR_WIDTH = 32,
       SRAM_ADDR_WIDTH = 20,
       SRAM_DATA_WIDTH = 16)
  (input  clk,
   input  rst_n,
   output data_rd_en,
   output data_wr_en,
   output [DATA_ADDR_WIDTH-1:0] data_addr,
   input  [(-1)+DATA_WIDTH:0] data_in,
   output [(-1)+DATA_WIDTH:0] data_out,
   output [SRAM_ADDR_WIDTH+(-1):0] sram_addr,
   output sram_ce_n,
   inout  [(-1)+SRAM_DATA_WIDTH:0] sram_dq,
   output sram_lb_n,
   output sram_oe_n,
   output sram_ub_n,
   output sram_we_n);


endmodule

