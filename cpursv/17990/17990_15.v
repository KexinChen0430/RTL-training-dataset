
module c_replicator(data_in,data_out);

  parameter  width = 32;
  parameter  count = 1<<1;
  input  [0:width+(-1)] data_in;
  output [0:(count*width)+(-1)] data_out;
  wire [0:(count*width)+(-1)] data_out;

  
  generate
      genvar idx;
      for (idx = 0; idx < width; idx = 1+idx)
          begin : idxs
            assign data_out[count*idx:(-1)+(count*(1+idx))] = {count{data_in[idx]}};
          end
  endgenerate

endmodule

