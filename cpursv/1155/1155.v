
module arriaiigz_nmux21(MO,A,B,S);

  input  A;
  input  B;
  input  S;
  output MO;

  assign MO = (S == 1) ? ~B : ~A;
endmodule

