
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w513,w8,w505,w32320,w31807,w2020,w29787;

  assign w1 = i_data0;
  assign w2020 = 1<<<(1+1)*w505;
  assign w29787 = (-w2020)+w31807;
  assign w31807 = (-w513)+w32320;
  assign w32320 = w505<<<6;
  assign w505 = w513+(0-w8);
  assign w512 = w1*((1+1)**9);
  assign w513 = w1+w512;
  assign w8 = ((1+1)**3)*w1;
  assign o_data0 = w29787;
endmodule

