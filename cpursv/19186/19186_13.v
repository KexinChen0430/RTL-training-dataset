
module Fadder_(carry,sum,in3,in2,in1);

  input  in1,in2,in3;
  output sum,carry;

  assign sum = in3 ^ (in2 ^ in1);
  assign carry = (in1 | in2) & ((in1 & (in2 | in3)) | in3);
endmodule

