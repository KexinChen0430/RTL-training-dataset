
module c_interleaver(data_in,data_out);

  parameter  width = 8;
  parameter  num_blocks = 2;
  localparam  step = width/num_blocks;
  input  [0:(0-1)+width] data_in;
  output [0:(0-1)+width] data_out;
  wire [0:(0-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < step; i = 1+i)
          begin : blocks
            genvar j;
            for (j = 0; j < num_blocks; j = 1+j)
                begin : bits
                  assign data_out[j+(i*num_blocks)] = data_in[i+(j*step)];
                end
          end
  endgenerate

endmodule

