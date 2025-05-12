
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
       total_value = ((((9'd0*Y)+(9'd30*Z))+(9'd5*X))+(((V*9'd3)+(9'd18*W))+((((((9'd7*R)+(9'd29*S))+((((9'd30*K)+(M*9'd16))+((I*9'd6)+(9'd8*L)))+((((J*9'd15)+(H*9'd14))+((((9'd12*F)+(9'd18*G))+((B*9'd8)+(C*9'd0)))+((9'd4*A)+(9'd20*D))))+(9'd10*E))))+((O*9'd18)+(9'd18*N)))+(9'd7*Q))+(P*9'd14))))+((U*9'd24)+(9'd23*T));
  wire [8:0] 
       total_weight = ((Z*9'd13)+(((9'd10*Y)+((9'd22*T)+(9'd1*S)))+((((9'd15*V)+(U*9'd26))+((((R*9'd26)+(9'd23*Q))+(9'd8*M))+((((9'd0*J)+(9'd13*L))+(((9'd5*K)+(((9'd6*G)+(I*9'd20))+(((F*9'd28)+(D*9'd18))+(((C*9'd27)+(B*9'd8))+((9'd28*A)+(9'd27*E))))))+(9'd1*H)))+((9'd14*N)+(9'd22*O)))))+(P*9'd12))))+((9'd0*W)+(9'd21*X));
  wire [8:0] 
       total_volume = (((9'd26*W)+((Z*9'd22)+(Y*9'd11)))+((9'd18*U)+(X*9'd3)))+(((9'd28*S)+(9'd16*V))+((((((((9'd28*N)+(((G*9'd4)+(9'd20*H))+((((9'd0*E)+((9'd27*B)+(A*9'd27)))+((9'd4*D)+(9'd4*C)))+(9'd24*F))))+((I*9'd12)+((9'd5*K)+(J*9'd15))))+(O*9'd19))+(9'd9*M))+(L*9'd2))+((9'd12*R)+(P*9'd18)))+((Q*9'd30)+(T*9'd13))));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

