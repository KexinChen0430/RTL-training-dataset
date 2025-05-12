
module difficult_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,valid);

  input  
      A,
      B,
      C,
      D,
      E,
      F,
      G,
      H,
      I,
      J,
      K,
      L,
      M,
      N,
      O,
      P,
      Q,
      R,
      S,
      T,
      U,
      V,
      W,
      X,
      Y,
      Z;
  output valid;
  wire [8:0]  min_value = 9'd180;
  wire [8:0]  max_weight = 9'd100;
  wire [8:0]  max_volume = 9'd100;
  wire [8:0] 
       total_value = ((((U*9'd24)+(9'd5*X))+(V*9'd3))+((((Q*9'd7)+((9'd23*T)+(S*9'd29)))+(R*9'd7))+(((9'd14*P)+((N+O)*9'd18))+((M*9'd16)+(((((J*9'd15)+(L*9'd8))+(9'd30*K))+((9'd6*I)+(G*9'd18)))+(((((9'd0*C)+(F*9'd12))+(B*9'd8))+((9'd4*A)+(9'd20*D)))+((H*9'd14)+(E*9'd10))))))))+(((9'd0*Y)+(Z*9'd30))+(9'd18*W));
  wire [8:0] 
       total_weight = (((((U*9'd26)+((9'd15*V)+(9'd0*W)))+((R*9'd26)+(9'd22*T)))+((((S*9'd1)+(9'd23*Q))+(((9'd22*O)+(N*9'd14))+(9'd12*P)))+((((9'd0*J)+((9'd8*M)+(L*9'd13)))+((9'd5*K)+(9'd1*H)))+(((9'd20*I)+((E*9'd27)+(D*9'd18)))+(((((C*9'd27)+(A*9'd28))+(B*9'd8))+(9'd28*F))+(9'd6*G))))))+(9'd13*Z))+((9'd21*X)+(9'd10*Y));
  wire [8:0] 
       total_volume = ((((X*9'd3)+(U*9'd18))+(((9'd16*V)+(9'd18*P))+((((9'd12*R)+(M*9'd9))+(((9'd19*O)+(((J*9'd15)+(9'd2*L))+(((9'd5*K)+(((9'd20*H)+(I*9'd12))+(G*9'd4)))+(((F*9'd24)+((9'd4*C)+(9'd27*A)))+(((B*9'd27)+(9'd4*D))+(E*9'd0))))))+(N*9'd28)))+(9'd30*Q))))+((S*9'd28)+(T*9'd13)))+(((9'd11*Y)+(9'd22*Z))+(9'd26*W));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule

