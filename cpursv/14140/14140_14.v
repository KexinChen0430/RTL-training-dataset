
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = (Clk & ~D) | (~Clk | (~D & D));
  assign R_g = ~Clk | D;
  assign Qa = R_g & ~Qb;
  assign Qb = S_g & ~Qa;
  assign Q = Qa;
endmodule

