
module c_reversor(data_in,data_out);

  parameter  width = 32;
  input  [0:(-1)+width] data_in;
  output [0:(-1)+width] data_out;
  wire [0:(-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = 1+i)
          begin : connect
            assign data_out[i] = data_in[((-i)+width)+(-1)];
          end
  endgenerate

endmodule

