
module Fadder_2(in1,in2,in3,sum,carry);

  input  in1,in2,in3;
  output sum,carry;

  assign sum = in3 ^ ((((in1 | in2) & ~in1) | ~in2) & (in1 | in2));
  assign carry = (((in3 & in1) | in2) & in1) | (in2 & in3);
endmodule

