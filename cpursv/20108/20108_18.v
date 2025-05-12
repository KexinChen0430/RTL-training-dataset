
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = a ^ ((~a & b) | (b & a));
        temp2 = (d & (~c | c)) ^ ((c & (d | ~d)) & (~c | c));
        z = ((temp1 & (~temp2 | temp2)) & ((temp1 | ~temp1) | (((~temp1 & (~temp2 & (temp1 & temp2))) ^ (~temp1 & ((temp1 & ~temp2) & (temp1 & (~temp2 | temp2))))) | (~temp1 & (temp2 & (~temp1 | ~temp2)))))) ^ (temp2 & ((temp1 | ~temp1) | (((~temp1 & (~temp2 & (temp1 & temp2))) ^ (~temp1 & ((temp1 & ~temp2) & (temp1 & (~temp2 | temp2))))) | (~temp1 & (temp2 & (~temp1 | ~temp2))))));
      end
endmodule

