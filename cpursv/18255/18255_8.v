
module FADDER(IN0,IN1,CIN,COUT,SUM);

  input  IN0,IN1,CIN;
  output COUT,SUM;

  assign SUM = ((IN0 & ~CIN) & ~(~CIN & IN1)) | ((~(IN0 ^ IN1) & CIN) | (IN1 & (~CIN & ~(IN0 & ~CIN))));
  assign COUT = (((IN0 & (CIN | IN1)) | IN1) & IN0) | ((CIN & (IN0 | IN1)) & IN1);
endmodule

