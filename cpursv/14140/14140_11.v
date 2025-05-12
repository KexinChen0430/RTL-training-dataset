
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = ((D & ~D) | ~Clk) | ~D;
  assign R_g = ((Clk | (D & ~D)) & D) | ((D & ~D) | ~Clk);
  assign Qa = R_g & ~Qb;
  assign Qb = ~Qa & S_g;
  assign Q = Qa;
endmodule

