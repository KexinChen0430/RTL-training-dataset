
module p2s_bit_reverse(din,dout);

  parameter  din_width = 8;
  parameter  dout_width = 1<<<1;
  parameter  num_outputs = 4;
  input  [din_width-1:0] din;
  output [din_width-1:0] dout;

  genvar index;
  
  generate
      for (index = 0; index < num_outputs; index = 1+index)
          begin : u0
            assign dout[(((-index)+num_outputs)*dout_width)-1:((-1)+((-index)+num_outputs))*dout_width] = din[((-1)+dout_width)+(index*dout_width):index*dout_width];
          end
  endgenerate

endmodule

