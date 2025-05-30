
module custom_engine_rx  #(parameter  BUF_SIZE = 10)
  (input  clock,
   input  reset,
   input  clear,
   input  set_stb,
   input  [7:0] set_addr,
   input  [31:0] set_data,
   output access_we,
   output access_stb,
   input  access_ok,
   output access_done,
   output access_skip_read,
   output [(-1)+BUF_SIZE:0] access_adr,
   input  [(-1)+BUF_SIZE:0] access_len,
   output [35:0] access_dat_o,
   input  [35:0] access_dat_i);

  assign access_done = access_ok;
endmodule

