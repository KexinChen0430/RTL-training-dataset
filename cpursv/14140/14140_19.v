
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = ~Clk | ~D;
  assign R_g = (~D & ~Clk) | D;
  assign Qa = R_g & ~Qb;
  assign Qb = ~Qa & S_g;
  assign Q = Qa;
endmodule

