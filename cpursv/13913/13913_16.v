
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
       total_value = ((9'd0*Y)+(9'd5*X))+(((9'd30*Z)+((9'd23*T)+((9'd3*V)+(9'd18*W))))+(((U*9'd24)+(9'd29*S))+((((9'd14*P)+(9'd16*M))+(((((K*9'd30)+(L*9'd8))+(((9'd15*J)+(G*9'd18))+((((9'd8*B)+(C*9'd0))+(9'd4*A))+(((E*9'd10)+(9'd20*D))+(9'd12*F)))))+((9'd14*H)+(I*9'd6)))+(N*9'd18)))+(((O*9'd18)+(9'd7*Q))+(R*9'd7)))));
  wire [8:0] 
       total_weight = ((((9'd21*X)+(9'd10*Y))+(9'd13*Z))+((9'd26*U)+(T*9'd22)))+((((9'd15*V)+(((R*9'd26)+(9'd1*S))+(9'd12*P)))+(((9'd23*Q)+(((K*9'd5)+(J*9'd0))+(((9'd13*L)+((F*9'd28)+(G*9'd6)))+((((H*9'd1)+(9'd20*I))+((9'd8*B)+((C*9'd27)+(A*9'd28))))+((9'd27*E)+(D*9'd18))))))+((M*9'd8)+((O*9'd22)+(N*9'd14)))))+(W*9'd0));
  wire [8:0] 
       total_volume = (((Y*9'd11)+(9'd22*Z))+(((U*9'd18)+(9'd3*X))+(9'd26*W)))+((9'd16*V)+(((((P*9'd18)+(9'd12*R))+(((L*9'd2)+(9'd28*N))+(((K*9'd5)+((9'd15*J)+(9'd12*I)))+((((9'd4*G)+(H*9'd20))+(D*9'd4))+(((9'd4*C)+((E*9'd0)+(F*9'd24)))+((A*9'd27)+(B*9'd27)))))))+((9'd19*O)+(M*9'd9)))+((9'd30*Q)+((9'd13*T)+(9'd28*S)))));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

