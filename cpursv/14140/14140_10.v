
module Dflop(Clk,D,Q);

  input  Clk,D;
  output Q;
  wire R_g,S_g,Qa,Qb;

  assign S_g = ~D | ~Clk;
  assign R_g = (~Clk | (((Clk | D) & ~D) & D)) | D;
  assign Qa = R_g & ~Qb;
  assign Qb = S_g & ~Qa;
  assign Q = Qa;
endmodule

