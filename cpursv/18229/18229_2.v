
module CC_ADDF(input  A,B,CI,
               output CO,S);

  assign {CO,S} = A+(CI+B);
endmodule

