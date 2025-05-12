
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = (((b & ~a) | (b & a)) & (~b | b)) ^ ((~b | b) & a);
        temp2 = (c & ~d) | (((c & (c & d)) ^ (c & d)) ^ ((d & (d & ((~d | d) & c))) ^ d));
        z = (~temp2 & temp1) | (((temp1 & (~temp2 | temp2)) & temp2) ^ temp2);
      end
endmodule

