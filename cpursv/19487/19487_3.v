
module Hadder_(carry,sum,in2,in1);

  input  in1,in2;
  output sum,carry;

  assign sum = ((in1 | ~in1) & (in1 & (~in2 | in2))) ^ in2;
  assign carry = in1 & in2;
endmodule

