
module sky130_fd_sc_hdll__muxb4to1(Z,D,S);

  output Z;
  input  [3:0] D;
  input  [3:0] S;

  bufif1 bufif10(.Z(Z),.I(!D[0]),.E(S[0]));
  bufif1 bufif11(.Z(Z),.I(!D[1]),.E(S[1]));
  bufif1 bufif12(.Z(Z),.I(!D[2]),.E(S[2]));
  bufif1 bufif13(.Z(Z),.I(!D[3]),.E(S[3]));
endmodule

