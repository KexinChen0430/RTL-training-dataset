
module Hadder_(carry,sum,in2,in1);

  input  in1,in2;
  output sum,carry;

  assign sum = in2 ^ ((((in1 ^ (in2 & in1)) | ~in1) | in2) & in1);
  assign carry = in2 & in1;
endmodule

