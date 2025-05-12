
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = ((((b | a) & ~a) | (~a | (b | a))) & ((((b | a) & ~a) | (~a | (b | a))) & a)) ^ ((((b | a) & ~a) | (~a | (b | a))) & (b & (((b | a) & ~a) | (~a | (b | a)))));
        temp2 = d ^ (c & (~d | d));
        z = (temp1 & ~temp2) | ((~temp1 & ((temp2 & (temp2 & temp1)) ^ temp2)) ^ (~temp1 & (((temp1 & ~temp2) | (~temp1 & temp1)) & temp2)));
      end
endmodule

