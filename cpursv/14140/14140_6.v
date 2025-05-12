
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = ~D | ~Clk;
  assign R_g = D | ~Clk;
  assign Qa = R_g & ~Qb;
  assign Qb = ~Qa & S_g;
  assign Q = Qa;
endmodule

