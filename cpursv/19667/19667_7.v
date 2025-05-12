
module param  #(parameter  width = 32)
  (output reg [31:0] pa_out,
   output wire [31:0] ca_out,
   input  [width+(0-1):0] in);

  wire  z_pad = 1'bz;
  wire  x_pad = 1'bx;

  assign ca_out = {{(-width)+32{z_pad}},in};
  
  always @* 
      pa_out = {{(-width)+32{x_pad}},in};
endmodule

