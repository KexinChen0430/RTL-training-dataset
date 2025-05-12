
module c_reverse(data_in,data_out);

  parameter  width = 32;
  input  [0:width-1] data_in;
  output [0:width-1] data_out;
  wire [0:width-1] data_out;

  
  generate
      genvar i;
      for (i = 0; i < width; i = 1+i)
          begin : connect
            assign data_out[i] = data_in[(-i)+(width-1)];
          end
  endgenerate

endmodule

