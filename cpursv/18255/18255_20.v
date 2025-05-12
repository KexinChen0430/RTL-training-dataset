
module FADDER(IN0,IN1,CIN,COUT,SUM);

  input  IN0,IN1,CIN;
  output COUT,SUM;

  assign SUM = ((~CIN & (IN1 & ~IN0)) | (((CIN | IN0) & ~(IN0 ^ IN1)) & CIN)) | (~CIN & (~IN1 & (IN0 & ((IN1 & ~IN0) | ~IN1))));
  assign COUT = (((IN1 & (CIN | IN0)) & CIN) | IN0) & (IN1 | (IN0 & CIN));
endmodule

