
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = (((~a & b) | (b & a)) & ((~a & (((~a & b) | (b & a)) | a)) | (a | ~a))) ^ (((~a & (((~a & b) | (b & a)) | a)) | (a | ~a)) & a);
        temp2 = ((d | (c & ~d)) & (((~c | c) | ((d | (c & ~d)) & ~c)) & ((c & (~d | d)) & (~c | (c & ~d))))) ^ ((d | (c & ~d)) & ((((~c | c) | ((d | (c & ~d)) & ~c)) & (((~c | c) & d) & d)) ^ (((~c | c) | ((d | (c & ~d)) & ~c)) & (c & d))));
        z = (((((temp2 ^ (temp1 & temp2)) | ~temp1) | ~temp2) & temp1) & (((temp2 & ~temp1) | (~temp1 & (temp1 & ~temp2))) | (temp1 | ~temp1))) ^ ((temp2 ^ (temp1 & temp2)) & (((temp2 & ~temp1) | (~temp1 & (temp1 & ~temp2))) | (temp1 | ~temp1)));
      end
endmodule

