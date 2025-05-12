
module c_replicator(data_in,data_out);

  parameter  width = 32;
  parameter  count = 2;
  input  [0:width-1] data_in;
  output [0:(-1)+(count*width)] data_out;
  wire [0:(-1)+(count*width)] data_out;

  
  generate
      genvar idx;
      for (idx = 0; idx < width; idx = 1+idx)
          begin : idxs
            assign data_out[count*idx:(-1)+((1+idx)*count)] = {count{data_in[idx]}};
          end
  endgenerate

endmodule

