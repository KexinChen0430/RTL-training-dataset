
module f1_test(a,b,c,d,z);

  input  a,b,c,d;
  output z;
  reg  z,temp1,temp2;

  
  always @(a or b or c or d)
      begin
        temp1 = b ^ a;
        temp2 = (((((d & (~c | c)) | c) | ~d) & c) & (~d | ~c)) ^ (d ^ ((((d & (~c | c)) | c) | ~d) & (d & c)));
        z = temp2 ^ temp1;
      end
endmodule

