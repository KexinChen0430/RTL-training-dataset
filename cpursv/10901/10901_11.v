
module dsi_byte_shifter(d_i,shifted_o,shift_i);

  parameter  g_data_bytes = 3;
  parameter  g_max_shift = 3;
  localparam  c_output_width = (g_max_shift+g_data_bytes)*8;
  input  [3:0] shift_i;
  input  [(8*g_data_bytes)-1:0] d_i;
  output [(-1)+c_output_width:0] shifted_o;
  wire [(-1)+c_output_width:0] gen_array[0:g_max_shift];

  genvar i;
  
  generate
      for (i = 0; i < g_max_shift; i = 1+i)
          assign gen_array[i] = d_i<<i*8;
  endgenerate

  assign shifted_o = gen_array[shift_i];
endmodule

