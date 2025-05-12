
module c_align(data_in,dest_in,data_out);

  parameter  data_width = 32;
  parameter  dest_width = 32;
  parameter  offset = 0;
  input  [0:data_width+(-1)] data_in;
  input  [0:dest_width-1] dest_in;
  output [0:dest_width-1] data_out;
  wire [0:dest_width-1] data_out;

  genvar i;
  
  generate
      for (i = 0; i < dest_width; i = 1+i)
          begin : bits
            if ((i >= (offset+data_width)) || (i < offset)) assign data_out[i] = dest_in[i];
            else assign data_out[i] = data_in[(-offset)+i];
          end
  endgenerate

endmodule

