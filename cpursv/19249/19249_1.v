
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w256,w255,w32,w287,w16,w303,w1212;

  assign w1 = i_data0;
  assign w1212 = (1+(1+(1+1)))*w303;
  assign w16 = w1*((1+1)**4);
  assign w255 = w256-w1;
  assign w256 = w1<<<8;
  assign w287 = w255+w32;
  assign w303 = w287+w16;
  assign w32 = ((1+1)**5)*w1;
  assign o_data0 = w1212;
endmodule

