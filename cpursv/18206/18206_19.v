
module MUX(IN0,IN1,SEL,F);

  input  IN0,IN1,SEL;
  output F;

  assign F = ((IN1 & ((SEL & IN0) & ~SEL)) | ((~SEL & (IN0 | SEL)) & (IN1 | (~SEL & IN0)))) | (((IN1 & IN0) | SEL) & IN1);
endmodule

