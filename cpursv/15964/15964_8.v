
module tvm_vpi_write_mmap  #(parameter 
       DATA_WIDTH      = 8,
       ADDR_WIDTH      = 8,
       BASE_ADDR_WIDTH = 32)
  (input  clk,
   input  rst,
   input  [ADDR_WIDTH+(-1):0] addr,
   input  [DATA_WIDTH+(-1):0] data_in,
   input  en,
   input  [(-1)+BASE_ADDR_WIDTH:0] mmap_addr);


endmodule

