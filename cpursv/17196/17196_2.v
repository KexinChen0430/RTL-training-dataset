
module c_interleave(data_in,data_out);

  parameter  width = 8;
  parameter  num_blocks = 1+1;
  localparam  step = (1/num_blocks)*width;
  input  [0:width-1] data_in;
  output [0:width-1] data_out;
  wire [0:width-1] data_out;

  
  generate
      genvar i;
      for (i = 0; i < step; i = 1+i)
          begin : blocks
            genvar j;
            for (j = 0; j < num_blocks; j = 1+j)
                begin : bits
                  assign data_out[j+(i*num_blocks)] = data_in[i+(step*j)];
                end
          end
  endgenerate

endmodule

