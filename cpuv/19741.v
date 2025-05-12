module TOP (
            SIG_NAMEB, SIG_NAMEA
            )
  output [223:0]     SIG_NAMEA; 
  output [FOO*4-2:0] SIG_NAMEB;                
  A A(
       .SIG_NAMEA                       (SIG_NAMEA[224*1-1:128*1]));
  B B(
       .SIG_NAMEA                       (SIG_NAMEA[127:0]));
  C C(
       .SIG_NAMEB                       (SIG_NAMEB[FOO*4-2*1:0]));
endmodule