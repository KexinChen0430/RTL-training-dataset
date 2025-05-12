
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w513,w4104,w4617,w64,w65,w18468,w18533;

  assign w1 = i_data0;
  assign w18468 = (2**2)*w4617;
  assign w18533 = w18468+w65;
  assign w4104 = w513<<<3;
  assign w4617 = w513+w4104;
  assign w512 = w1*(2**9);
  assign w513 = w1+w512;
  assign w64 = w1<<<6;
  assign w65 = w64+w1;
  assign o_data0 = w18533;
endmodule

