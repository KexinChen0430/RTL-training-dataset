
module p2s_bit_reverse(din,dout);

  parameter  din_width = 8;
  parameter  dout_width = 1+1;
  parameter  num_outputs = 4;
  input  [din_width+(0-1):0] din;
  output [din_width+(0-1):0] dout;

  genvar index;
  
  generate
      for (index = 0; index < num_outputs; index = 1+index)
          begin : u0
            assign dout[(dout_width*(num_outputs-index))+(0-1):((0-index)+(num_outputs+(0-1)))*dout_width] = din[((index*dout_width)+dout_width)+(0-1):index*dout_width];
          end
  endgenerate

endmodule

