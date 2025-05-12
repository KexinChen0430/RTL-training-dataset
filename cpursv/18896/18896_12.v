
module c_reversor(data_in,data_out);

  parameter  width = 32;
  input  [0:(-1)+width] data_in;
  output [0:(-1)+width] data_out;
  wire [0:(-1)+width] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = i+1)
          begin : connect
            assign data_out[i] = data_in[((-1)+width)+(0-i)];
          end
  endgenerate

endmodule

