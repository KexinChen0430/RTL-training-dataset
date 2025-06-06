
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
  assign w128 = (2**7)*w1;
  assign w16 = w1<<<4;
  assign w24465 = w24593+(0-w128);
  assign w24577 = w32769-w8192;
  assign w24593 = w16+w24577;
  assign w32768 = w1<<15;
  assign w32769 = w32768+w1;
  assign w8192 = w1*(2**13);
  assign o_data0 = w24465;
endmodule

