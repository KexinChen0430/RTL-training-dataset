
module c_interleave(data_in,data_out);

  parameter  width = 8;
  parameter  num_blocks = 1<<<1;
  localparam  step = width/num_blocks;
  input  [0:(-1)+width] data_in;
  output [0:(-1)+width] data_out;
  wire [0:(-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < step; i = i+1)
          begin : blocks
            genvar j;
            for (j = 0; j < num_blocks; j = 1+j)
                begin : bits
                  assign data_out[j+(i*num_blocks)] = data_in[(j*step)+i];
                end
          end
  endgenerate

endmodule

