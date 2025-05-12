
module p2s_bit_reverse(din,dout);

  parameter  din_width = 8;
  parameter  dout_width = 1<<<1;
  parameter  num_outputs = 4;
  input  [(0-1)+din_width:0] din;
  output [(0-1)+din_width:0] dout;

  genvar index;
  
  generate
      for (index = 0; index < num_outputs; index = index+1)
          begin : u0
            assign dout[(0-1)+((num_outputs-index)*dout_width):((num_outputs-index)+(0-1))*dout_width] = din[(dout_width+(0-1))+(index*dout_width):index*dout_width];
          end
  endgenerate

endmodule

