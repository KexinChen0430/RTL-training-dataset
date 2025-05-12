
module MUXCY(O,CI,DI,S);

  output O;
  input  CI,DI,S;
  reg  O_out;

  
  always @(CI or DI or S)
      if (S) O_out = CI;
      else O_out = DI;
  assign O = O_out;
endmodule

