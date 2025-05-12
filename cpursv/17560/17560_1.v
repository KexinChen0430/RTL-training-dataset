
module xp(ri,e);

  input  [1:32] ri;
  output [1:48] e;

  assign e[1] = ri[32];
  assign e[2] = ri[1];
  assign e[3] = ri[2];
  assign e[4] = ri[3];
  assign e[5] = ri[4];
  assign e[6] = ri[5];
  assign e[7] = ri[4];
  assign e[8] = ri[5];
endmodule

