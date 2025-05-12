
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w33,w1024,w991,w528,w463,w7408,w7407;

  assign w1 = i_data0;
  assign w1024 = (1<<1**10)*w1;
  assign w32 = w1<<5;
  assign w33 = w1+w32;
  assign w463 = (0-w528)+w991;
  assign w528 = (1<<1**4)*w33;
  assign w7407 = (-w1)+w7408;
  assign w7408 = (1<<1**4)*w463;
  assign w991 = w1024-w33;
  assign o_data0 = w7407;
endmodule

