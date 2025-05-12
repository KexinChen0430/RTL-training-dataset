
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
       total_value = (((X*9'd5)+(9'd30*Z))+(((Y*9'd0)+((((9'd24*U)+(T*9'd23))+(((9'd7*(Q+R))+(((K*9'd30)+(9'd8*L))+((N*9'd18)+(((H*9'd14)+((9'd6*I)+(9'd15*J)))+((F*9'd12)+(((G*9'd18)+((9'd10*E)+(D*9'd20)))+((C*9'd0)+((9'd4*A)+(9'd8*B)))))))))+(M*9'd16)))+((9'd14*P)+(O*9'd18))))+(S*9'd29)))+((9'd3*V)+(W*9'd18));
  wire [8:0] 
       total_weight = (((9'd21*X)+(Y*9'd10))+(9'd13*Z))+(((((9'd23*Q)+(9'd12*P))+((((R*9'd26)+(S*9'd1))+(((((H*9'd1)+(9'd5*K))+((F*9'd28)+((E*9'd27)+(((C*9'd27)+(9'd18*D))+((9'd8*B)+(9'd28*A))))))+((9'd6*G)+(9'd20*I)))+((9'd13*L)+(J*9'd0))))+(((N*9'd14)+(9'd22*O))+(9'd8*M))))+((9'd15*V)+(9'd0*W)))+((9'd22*T)+(9'd26*U)));
  wire [8:0] 
       total_volume = ((((9'd16*V)+(W*9'd26))+((U*9'd18)+(9'd13*T)))+((((Q*9'd30)+((R*9'd12)+(S*9'd28)))+((((9'd12*I)+(9'd15*J))+((((L*9'd2)+(9'd5*K))+((F*9'd24)+((H*9'd20)+(G*9'd4))))+(((9'd4*D)+(C*9'd4))+(((E*9'd0)+(9'd27*A))+(9'd27*B)))))+(N*9'd28)))+(((9'd9*M)+(O*9'd19))+(9'd18*P))))+(((9'd11*Y)+(9'd3*X))+(Z*9'd22));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule

