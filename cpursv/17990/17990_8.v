
module c_replicator(data_in,data_out);

  parameter  width = 32;
  parameter  count = 1+1;
  input  [0:(0-1)+width] data_in;
  output [0:(count*width)-1] data_out;
  wire [0:(count*width)-1] data_out;

  
  generate
      genvar idx;
      for (idx = 0; idx < width; idx = 1+idx)
          begin : idxs
            assign data_out[idx*count:(0-1)+((1+idx)*count)] = {count{data_in[idx]}};
          end
  endgenerate

endmodule

