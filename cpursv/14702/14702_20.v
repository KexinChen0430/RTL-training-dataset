
module c_align(data_in,dest_in,data_out);

  parameter  in_width = 32;
  parameter  out_width = 32;
  parameter  offset = 0;
  input  [0:in_width+(0-1)] data_in;
  input  [0:out_width-1] dest_in;
  output [0:out_width-1] data_out;
  wire [0:out_width-1] data_out;

  genvar i;
  
  generate
      for (i = 0; i < out_width; i = 1+i)
          begin : bits
            if ((i < offset) || (i >= (in_width+offset))) assign data_out[i] = dest_in[i];
            else assign data_out[i] = data_in[i+(-offset)];
          end
  endgenerate

endmodule

