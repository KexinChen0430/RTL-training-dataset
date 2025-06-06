
module c_and_nto1(data_in,data_out);

  parameter  num_ports = 2;
  parameter  width = 1;
  input  [0:(0-1)+(num_ports*width)] data_in;
  output [0:(0-1)+width] data_out;
  wire [0:(0-1)+width] data_out;

  
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
            assign data_out[i] = &data;
          end
  endgenerate

endmodule

