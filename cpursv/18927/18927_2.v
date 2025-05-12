
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w513,w8,w505,w32320,w31807,w2020,w29787;

  assign w1 = i_data0;
  assign w2020 = ((1+1)*(1+1))*w505;
  assign w29787 = w31807-w2020;
  assign w31807 = w32320+(0-w513);
  assign w32320 = ((1+1)**6)*w505;
  assign w505 = (0-w8)+w513;
  assign w512 = w1<<<9;
  assign w513 = w1+w512;
  assign w8 = ((1+1)**3)*w1;
  assign o_data0 = w29787;
endmodule

