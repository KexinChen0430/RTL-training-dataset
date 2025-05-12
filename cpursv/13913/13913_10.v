
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
       total_value = ((((Z*9'd30)+(Y*9'd0))+(W*9'd18))+((9'd5*X)+(9'd3*V)))+(((9'd24*U)+(S*9'd29))+(((9'd7*R)+(9'd7*Q))+(((9'd23*T)+(((P*9'd14)+(9'd18*O))+(N*9'd18)))+(((((((H*9'd14)+(9'd18*G))+(F*9'd12))+(((D*9'd20)+(E*9'd10))+(9'd8*B)))+((9'd0*C)+(A*9'd4)))+((9'd15*J)+(9'd6*I)))+(((M*9'd16)+(K*9'd30))+(L*9'd8))))));
  wire [8:0] 
       total_weight = (((Z*9'd13)+(9'd10*Y))+(((((9'd22*T)+(9'd26*U))+((((P*9'd12)+(R*9'd26))+(((K*9'd5)+(((L*9'd13)+(J*9'd0))+(((((9'd1*H)+(9'd6*G))+(I*9'd20))+((9'd18*D)+(F*9'd28)))+(((A*9'd28)+(C*9'd27))+((E*9'd27)+(9'd8*B))))))+((9'd8*M)+(O*9'd22))))+(N*9'd14)))+((9'd23*Q)+(9'd1*S)))+((W*9'd0)+(9'd15*V))))+(X*9'd21);
  wire [8:0] 
       total_volume = ((9'd3*X)+(9'd22*Z))+(((9'd16*V)+(9'd26*W))+((Y*9'd11)+((((S*9'd28)+((T*9'd13)+(U*9'd18)))+(((R*9'd12)+(P*9'd18))+(((((9'd15*J)+(9'd9*M))+((((K*9'd5)+(9'd12*I))+(((9'd0*E)+(((B+A)*9'd27)+(C*9'd4)))+(D*9'd4)))+(((9'd24*F)+(9'd20*H))+(G*9'd4))))+((9'd19*O)+(9'd28*N)))+(L*9'd2))))+(Q*9'd30))));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

