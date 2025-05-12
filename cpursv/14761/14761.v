
module MUXF8(O,I0,I1,S);

  output O;
  input  I0,I1,S;
  reg  O_out;

  
  always @(I0 or I1 or S)
      if (S) O_out = I1;
      else O_out = I0;
  assign O = O_out;
endmodule

