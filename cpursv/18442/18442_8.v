
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w32768,
      w32769,
      w8192 ,
      w24577,
      w16   ,
      w24593,
      w128  ,
      w24465;

  assign w1 = i_data0;
  assign w128 = w1*(1<<<1**7);
  assign w16 = w1<<<4;
  assign w24465 = (0-w128)+w24593;
  assign w24577 = w32769+(-w8192);
  assign w24593 = w16+w24577;
  assign w32768 = w1<<15;
  assign w32769 = w1+w32768;
  assign w8192 = (1<<<1**13)*w1;
  assign o_data0 = w24465;
endmodule

