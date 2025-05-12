
module c_interleave(data_in,data_out);

  parameter  width = 8;
  parameter  num_blocks = 1<<<1;
  localparam  step = (1/num_blocks)*width;
  input  [0:(0-1)+width] data_in;
  output [0:(0-1)+width] data_out;
  wire [0:(0-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < step; i = i+1)
          begin : blocks
            genvar j;
            for (j = 0; j < num_blocks; j = 1+j)
                begin : bits
                  assign data_out[j+(num_blocks*i)] = data_in[(j*step)+i];
                end
          end
  endgenerate

endmodule

