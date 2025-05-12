
module p2s_bit_reverse(din,dout);

  parameter  din_width = 8;
  parameter  dout_width = 1+1;
  parameter  num_outputs = 4;
  input  [(-1)+din_width:0] din;
  output [(-1)+din_width:0] dout;

  genvar index;
  
  generate
      for (index = 0; index < num_outputs; index = index+1)
          begin : u0
            assign dout[((num_outputs+(0-index))*dout_width)-1:dout_width*((num_outputs+(0-index))-1)] = din[((index*dout_width)+(-1))+dout_width:index*dout_width];
          end
  endgenerate

endmodule

