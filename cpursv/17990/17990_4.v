
module c_replicator(data_in,data_out);

  parameter  width = 32;
  parameter  count = 1<<<1;
  input  [0:width+(-1)] data_in;
  output [0:(-1)+(width*count)] data_out;
  wire [0:(-1)+(width*count)] data_out;

  
  generate
      genvar idx;
      for (idx = 0; idx < width; idx = idx+1)
          begin : idxs
            assign data_out[idx*count:(count*(idx+1))+(-1)] = {count{data_in[idx]}};
          end
  endgenerate

endmodule

