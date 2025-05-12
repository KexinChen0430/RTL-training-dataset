
module c_replicator(data_in,data_out);

  parameter  width = 32;
  parameter  count = 1<<<1;
  input  [0:(-1)+width] data_in;
  output [0:(count*width)+(-1)] data_out;
  wire [0:(count*width)+(-1)] data_out;

  
  generate
      genvar idx;
      for (idx = 0; idx < width; idx = idx+1)
          begin : idxs
            assign data_out[idx*count:(-1)+((idx+1)*count)] = {count{data_in[idx]}};
          end
  endgenerate

endmodule

