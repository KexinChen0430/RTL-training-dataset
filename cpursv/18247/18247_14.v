
module HADDER(IN0,IN1,SUM,COUT);

  input  IN0,IN1;
  output SUM,COUT;

  assign SUM = ((IN1 & ~((IN1 | ~IN1) & (((IN1 | ~IN1) & IN0) & (IN0 | ~IN0)))) | ~IN1) & ((IN1 & ~((IN1 | ~IN1) & (((IN1 | ~IN1) & IN0) & (IN0 | ~IN0)))) | ((IN1 | ~IN1) & (((IN1 | ~IN1) & IN0) & (IN0 | ~IN0))));
  assign COUT = IN0 & IN1;
endmodule

