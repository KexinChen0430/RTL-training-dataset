
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = (((~a & (b & ((a & ~a) | (a & (~b & (b | ((~b | b) & a))))))) ^ (~a & (b ^ (b & (((~b | b) & a) & b))))) ^ (a & ~a)) | ((a & ((((b | ((~b | b) & a)) | ~a) | ((b | ((~b | b) & a)) & (~a & (~b | b)))) & b)) ^ (a & ((((b | ((~b | b) & a)) | ~a) | ((b | ((~b | b) & a)) & (~a & (~b | b)))) & a)));
        temp2 = (d | (c & (d | ~d))) & (((d ^ ((c & (d | ~d)) & d)) | ~c) | ~d);
        z = temp2 ^ ((~temp2 | temp2) & (temp1 & (~temp2 | temp2)));
      end
endmodule

