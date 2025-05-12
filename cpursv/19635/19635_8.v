
module Fadder_2(in1,in2,in3,sum,carry);

  input  in1,in2,in3;
  output sum,carry;

  assign sum = ((in2 | (in1 & ~in2)) | (~(((~in1 & (in2 | (in1 & ~in2))) & in2) | (in1 & ((in1 & ~in2) | ~in1))) & in3)) & ((~(((~in1 & (in2 | (in1 & ~in2))) & in2) | (in1 & ((in1 & ~in2) | ~in1))) & in3) | (((in1 & ~in2) & ~in3) | (~in3 & ~in1)));
  assign carry = ((in3 & in1) | (in3 & in2)) | (in1 & in2);
endmodule

