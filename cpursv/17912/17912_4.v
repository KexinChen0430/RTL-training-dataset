
module c_select_mofn(select,data_in,data_out);

  parameter  num_ports = 4;
  parameter  width = 32;
  input  [0:num_ports+(0-1)] select;
  input  [0:(0-1)+(width*num_ports)] data_in;
  output [0:(0-1)+width] data_out;
  wire [0:(0-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = i+1)
          begin : width_loop
            wire [0:num_ports+(0-1)] port_bits;

            genvar j;
            for (j = 0; j < num_ports; j = j+1)
                begin : ports_loop
                  assign port_bits[j] = data_in[(width*j)+i] & select[j];
                end
            assign data_out[i] = |port_bits;
          end
  endgenerate

endmodule

