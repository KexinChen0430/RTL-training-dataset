
module rca(a0,a1,a2,a3,a4,a5,a6,a7,b0,b1,b2,b3,b4,b5,b6,b7,car1,car2,
           car3,car4,car5,car6,car7,car8,s0,s1,s2,s3,s4,s5,s6,s7);

  input  a0,a1,a2,a3,a4,a5,a6,a7,b0,b1,b2,b3,b4,b5,b6,b7;
  output 
      car1,
      car2,
      car3,
      car4,
      car5,
      car6,
      car7,
      car8,
      s0  ,
      s1  ,
      s2  ,
      s3  ,
      s4  ,
      s5  ,
      s6  ,
      s7  ;

  assign s0 = (~((~a0 & b0) | (a0 & ~b0)) & 0) | ((~0 & (~a0 & b0)) | (~0 & (a0 & ~b0)));
  assign car1 = (((((~a0 & b0) | (a0 & ~b0)) | b0) & ((~a0 & b0) | (a0 & ~b0))) | ((((~a0 & b0) | (a0 & ~b0)) | b0) & a0)) & ((0 | b0) & (0 | a0));
  assign s1 = (((((~(((a1 & ~b1) | b1) & (~a1 | ~b1)) | ((~car1 & ~b1) & a1)) | (~car1 & (~a1 & b1))) & (b1 & ~car1)) & ~(((~(((a1 & ~b1) | b1) & (~a1 | ~b1)) | ((~car1 & ~b1) & a1)) | (~car1 & (~a1 & b1))) & (a1 & ~car1))) | (~(((~(((a1 & ~b1) | b1) & (~a1 | ~b1)) | ((~car1 & ~b1) & a1)) | (~car1 & (~a1 & b1))) & (b1 & ~car1)) & (((~(((a1 & ~b1) | b1) & (~a1 | ~b1)) | ((~car1 & ~b1) & a1)) | (~car1 & (~a1 & b1))) & (a1 & ~car1)))) | (~(((a1 & ~b1) | b1) & (~a1 | ~b1)) & car1);
  assign car2 = ((b1 & a1) | ((a1 | (((a1 & ~b1) | b1) & (~a1 | ~b1))) & ((((a1 & ~b1) | b1) & (~a1 | ~b1)) | b1))) & ((b1 & a1) | car1);
  assign s2 = (((car2 & ~((b2 & ~a2) | (a2 & ~b2))) | ~car2) & (car2 & ~((b2 & ~a2) | (a2 & ~b2)))) | (((car2 & ~((b2 & ~a2) | (a2 & ~b2))) | ~car2) & ((b2 & ~a2) | (a2 & ~b2)));
  assign car3 = (((((b2 | car2) & (a2 | car2)) & a2) & ~b2) | (b2 & a2)) | ((b2 & car2) & ~a2);
  assign s3 = (car3 & ~((~b3 | ~a3) & ((~a3 & b3) | a3))) | (~car3 & ((~b3 | ~a3) & ((~a3 & b3) | a3)));
  assign car4 = (a3 & b3) | (((~b3 | ~a3) & ((~a3 & b3) | a3)) & car3);
  assign s4 = (car4 & ~(a4 ^ b4)) | ((~car4 & (((~a4 | ~b4) & a4) & ~b4)) | ((~a4 & b4) & ~car4));
  assign car5 = (~a4 & (b4 & car4)) | ((a4 & b4) | (a4 & (~b4 & car4)));
  assign s5 = (((car5 | ~car5) & (car5 | (a5 ^ b5))) & (((~(a5 ^ b5) | ~car5) & ((~(a5 ^ b5) | ~car5) & ((~(a5 ^ b5) | ~car5) & (b5 & ~car5)))) ^ ((~(a5 ^ b5) | ~car5) & ((~(a5 ^ b5) | ~car5) & ((~(a5 ^ b5) | ~car5) & (a5 & ~car5)))))) | (((car5 | ~car5) & (car5 | (a5 ^ b5))) & ~(a5 ^ b5));
  assign car6 = (b5 & (car5 & ~a5)) | (((car5 | (a5 & b5)) & (~b5 & a5)) | (a5 & b5));
  assign s6 = (a6 ^ b6) ^ car6;
  assign car7 = ((a6 & b6) | ((car6 & ~a6) & b6)) | (a6 & (~b6 & car6));
  assign s7 = car7 ^ ((b7 & ~a7) | (a7 & ~b7));
  assign car8 = (((((b7 & a7) | ~a7) & ((b7 & a7) | b7)) | ~b7) & ((((b7 & a7) | ~a7) & ((b7 & a7) | b7)) | a7)) & ((car7 | a7) & (car7 | b7));
endmodule

