
module c_select_mofn(select,data_in,data_out);

  parameter  num_ports = 4;
  parameter  width = 32;
  input  [0:num_ports-1] select;
  input  [0:(width*num_ports)-1] data_in;
  output [0:(-1)+width] data_out;
  wire [0:(-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = 1+i)
          begin : width_loop
            wire [0:num_ports-1] port_bits;

            genvar j;
            for (j = 0; j < num_ports; j = 1+j)
                begin : ports_loop
                  assign port_bits[j] = select[j] & data_in[i+(j*width)];
                end
            assign data_out[i] = |port_bits;
          end
  endgenerate

endmodule

