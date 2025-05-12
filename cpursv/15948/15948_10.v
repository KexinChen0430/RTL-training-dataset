
module tvm_vpi_read_mmap  #(parameter 
       DATA_WIDTH      = 8,
       ADDR_WIDTH      = 8,
       BASE_ADDR_WIDTH = 32)
  (input  clk,
   input  rst,
   input  [(0-1)+ADDR_WIDTH:0] addr,
   output [(0-1)+DATA_WIDTH:0] data_out,
   input  [BASE_ADDR_WIDTH+(0-1):0] mmap_addr);

  reg  [(0-1)+DATA_WIDTH:0] reg_data;

  assign data_out = reg_data;
endmodule

