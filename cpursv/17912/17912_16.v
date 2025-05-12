
module c_select_mofn(select,data_in,data_out);

  parameter  num_ports = 4;
  parameter  width = 32;
  input  [0:num_ports-1] select;
  input  [0:(num_ports*width)-1] data_in;
  output [0:width-1] data_out;
  wire [0:width-1] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = 1+i)
          begin : width_loop
            wire [0:num_ports-1] port_bits;

            genvar j;
            for (j = 0; j < num_ports; j = j+1)
                begin : ports_loop
                  assign port_bits[j] = select[j] & data_in[i+(width*j)];
                end
            assign data_out[i] = |port_bits;
          end
  endgenerate

endmodule

