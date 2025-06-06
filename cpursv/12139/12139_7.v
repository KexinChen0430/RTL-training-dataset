
module syntheses_implementation_interface_in(input  ready_out,
                                             input  [(-1)+32:0] data_in,
                                             input  [1-1:0] last_in,
                                             input  [1-1:0] reset_in,
                                             input  [(-1)+8:0] set_addr_in,
                                             input  [1-1:0] set_stb_in,
                                             input  [1-1:0] valid_in);

  wire [1-1:0] set_stb_in_net;
  wire [1-1:0] valid_in_net;
  wire [1-1:0] last_in_net;
  wire [1-1:0] reset_in_net;
  wire [(-1)+8:0] set_addr_in_net;
  wire 
      ifft_fast_fourier_transform_8_1_s_axis_data_tready_net;
  wire [(-1)+32:0] data_in_net;

  assign ifft_fast_fourier_transform_8_1_s_axis_data_tready_net = ready_out;
  assign data_in_net = data_in;
  assign last_in_net = last_in;
  assign reset_in_net = reset_in;
  assign set_addr_in_net = set_addr_in;
  assign set_stb_in_net = set_stb_in;
  assign valid_in_net = valid_in;
endmodule

