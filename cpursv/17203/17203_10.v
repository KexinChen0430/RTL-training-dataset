
module test(i1,i2,i3,i4,i5,i6,i7,i8,s1,s2,s3,a1);

  input  a1,s1,s2,s3;
  output i1,i2,i3,i4,i5,i6,i7,i8;

  assign i1 = (a1 & !s2) & (!s1 & !s3);
  assign i2 = (a1 & !s2) & (!s1 & s3);
  assign i3 = (!s3 & (a1 & s1)) & !s2;
  assign i4 = !s1 & ((s2 & s3) & a1);
  assign i5 = (!s3 & (a1 & s1)) & !s2;
  assign i6 = (!s2 & s1) & (a1 & s3);
  assign i7 = (!s3 & (a1 & s1)) & s2;
  assign i8 = (s3 & s1) & (a1 & s2);
endmodule

