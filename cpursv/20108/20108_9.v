
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = (((~b | ((b | a) & ~a)) & (a & (b | ~b))) | b) & (~b | ((b | a) & ~a));
        temp2 = d ^ (c & (d | ~d));
        z = temp2 ^ temp1;
      end
endmodule

