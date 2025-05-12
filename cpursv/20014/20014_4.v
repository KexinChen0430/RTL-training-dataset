
module p2s_bit_reverse(din,dout);

  parameter  din_width = 8;
  parameter  dout_width = 2;
  parameter  num_outputs = 4;
  input  [(-1)+din_width:0] din;
  output [(-1)+din_width:0] dout;

  genvar index;
  
  generate
      for (index = 0; index < num_outputs; index = 1+index)
          begin : u0
            assign dout[((num_outputs-index)*dout_width)-1:dout_width*(((-1)+num_outputs)+(-index))] = din[((-1)+(dout_width*index))+dout_width:dout_width*index];
          end
  endgenerate

endmodule

