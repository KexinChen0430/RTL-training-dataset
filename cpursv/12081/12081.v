
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (A ^ B) ^ C;
endmodule

