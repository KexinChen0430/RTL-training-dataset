module sdio_cis ( 
  input                     clk, 
  input                     rst, 
  input                     i_activate, 
  input                     i_ready, 
  output                    o_ready, 
  output                    o_finished, 
  input                     i_write_flag, 
  input                     i_inc_addr, 
  input         [17:0]      i_address, 
  input                     i_data_stb, 
  input         [17:0]      i_data_count, 
  input         [7:0]       i_data_in, 
  output        [7:0]       o_data_out, 
  output                    o_data_stb 
);
endmodule 