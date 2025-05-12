
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
       total_value = ((((9'd30*Z)+(9'd5*X))+(9'd0*Y))+(((((Q*9'd7)+(9'd29*S))+(P*9'd14))+(((R*9'd7)+(((O*9'd18)+((K*9'd30)+(9'd15*J)))+(((L*9'd8)+(9'd6*I))+(((H*9'd14)+((F*9'd12)+(E*9'd10)))+((G*9'd18)+(((9'd8*B)+((C*9'd0)+(A*9'd4)))+(9'd20*D)))))))+((M*9'd16)+(N*9'd18))))+((9'd23*T)+(V*9'd3))))+((U*9'd24)+(9'd18*W));
  wire [8:0] 
       total_weight = (((9'd10*Y)+(Z*9'd13))+(((9'd21*X)+(9'd15*V))+(9'd0*W)))+(((U*9'd26)+((9'd26*R)+(9'd1*S)))+(((T*9'd22)+((9'd23*Q)+((((9'd14*N)+(M*9'd8))+(((9'd1*H)+(I*9'd20))+(((9'd18*D)+((((9'd27*C)+(9'd8*B))+(A*9'd28))+(F*9'd28)))+((G*9'd6)+(9'd27*E)))))+(((9'd5*K)+(9'd0*J))+(L*9'd13)))))+((O*9'd22)+(9'd12*P))));
  wire [8:0] 
       total_volume = ((9'd26*W)+((9'd11*Y)+(9'd22*Z)))+((((X*9'd3)+(((9'd12*R)+(9'd13*T))+((S*9'd28)+((((N*9'd28)+(9'd19*O))+((9'd30*Q)+(P*9'd18)))+((((9'd5*K)+((L*9'd2)+(M*9'd9)))+((((F*9'd24)+((A*9'd27)+(9'd4*C)))+(((9'd4*D)+(E*9'd0))+(B*9'd27)))+(((9'd4*G)+(9'd20*H))+(9'd12*I))))+(9'd15*J))))))+(9'd16*V))+(9'd18*U));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

