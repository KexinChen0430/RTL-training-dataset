
module c_xor_nto1(data_in,data_out);

  parameter  num_ports = 1<<1;
  parameter  width = 1;
  input  [0:(num_ports*width)-1] data_in;
  output [0:width-1] data_out;
  wire [0:width-1] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = 1+i)
          begin : bit_positions
            wire [0:num_ports-1] data;

            genvar j;
            for (j = 0; j < num_ports; j = 1+j)
                begin : input_ports
                  assign data[j] = data_in[(width*j)+i];
                end
            assign data_out[i] = ^data;
          end
  endgenerate

endmodule

