
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = ((~D & D) | ~Clk) | (~D & Clk);
  assign R_g = D | ~Clk;
  assign Qa = ~Qb & R_g;
  assign Qb = S_g & ~Qa;
  assign Q = Qa;
endmodule

