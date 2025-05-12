
module c_interleaver(data_in,data_out);

  parameter  width = 8;
  parameter  num_blocks = 1<<<1;
  localparam  step = (1/num_blocks)*width;
  input  [0:width-1] data_in;
  output [0:width-1] data_out;
  wire [0:width-1] data_out;

  
  generate
      genvar i;
      for (i = 0; i < step; i = i+1)
          begin : blocks
            genvar j;
            for (j = 0; j < num_blocks; j = j+1)
                begin : bits
                  assign data_out[(num_blocks*i)+j] = data_in[i+(j*step)];
                end
          end
  endgenerate

endmodule

