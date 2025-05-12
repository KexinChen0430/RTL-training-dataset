
module c_align(data_in,dest_in,data_out);

  parameter  in_width = 32;
  parameter  out_width = 32;
  parameter  offset = 0;
  input  [0:in_width-1] data_in;
  input  [0:(-1)+out_width] dest_in;
  output [0:(-1)+out_width] data_out;
  wire [0:(-1)+out_width] data_out;

  genvar i;
  
  generate
      for (i = 0; i < out_width; i = 1+i)
          begin : bits
            if ((i < offset) || (i >= (offset+in_width))) assign data_out[i] = dest_in[i];
            else assign data_out[i] = data_in[i-offset];
          end
  endgenerate

endmodule

