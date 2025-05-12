
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
       total_value = (((9'd5*X)+((Z*9'd30)+(9'd0*Y)))+(((U*9'd24)+(V*9'd3))+(W*9'd18)))+(((((((N*9'd18)+(O*9'd18))+((K*9'd30)+(9'd15*J)))+((((9'd16*M)+(9'd8*L))+((((9'd6*I)+(H*9'd14))+((9'd20*D)+(C*9'd0)))+(((E*9'd10)+((B*9'd8)+(9'd4*A)))+(9'd12*F))))+(G*9'd18)))+(9'd29*S))+((9'd14*P)+(9'd7*Q)))+((R*9'd7)+(9'd23*T)));
  wire [8:0] 
       total_weight = ((X*9'd21)+((9'd10*Y)+(Z*9'd13)))+(((((((((9'd22*O)+(M*9'd8))+(9'd12*P))+(((9'd14*N)+(J*9'd0))+((9'd5*K)+(((I*9'd20)+(((F*9'd28)+((B*9'd8)+(9'd27*C)))+(((D*9'd18)+(E*9'd27))+(9'd28*A))))+((9'd6*G)+(9'd1*H))))))+(L*9'd13))+(S*9'd1))+(Q*9'd23))+((R*9'd26)+(9'd22*T)))+(((9'd0*W)+(U*9'd26))+(9'd15*V)));
  wire [8:0] 
       total_volume = (((X*9'd3)+(9'd26*W))+(((Z*9'd22)+((V*9'd16)+(9'd18*U)))+((((((9'd30*Q)+(9'd12*R))+(9'd28*S))+(((((M*9'd9)+(9'd5*K))+(L*9'd2))+(((9'd15*J)+((D*9'd4)+(9'd0*E)))+((((G*9'd4)+(F*9'd24))+((9'd4*C)+(B*9'd27)))+(9'd27*A))))+((H*9'd20)+(9'd12*I))))+(((9'd28*N)+(9'd19*O))+(P*9'd18)))+(T*9'd13))))+(Y*9'd11);

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule

