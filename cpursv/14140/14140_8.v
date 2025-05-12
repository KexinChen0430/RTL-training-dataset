
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = (((~D | Clk) & ~Clk) | ~D) | ~Clk;
  assign R_g = ~Clk | D;
  assign Qa = ~Qb & R_g;
  assign Qb = ~Qa & S_g;
  assign Q = Qa;
endmodule

