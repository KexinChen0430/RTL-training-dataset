
module param  #(parameter  width = 32)
  (output reg [31:0] pa_out,
   output wire [31:0] ca_out,
   input  [width+(0-1):0] in);

  assign ca_out = {{(0-width)+32{1'bz}},in};
  
  always @* 
      pa_out = {{(0-width)+32{1'bx}},in};
endmodule

