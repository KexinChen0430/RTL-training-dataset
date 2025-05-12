
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
       total_value = ((((Z*9'd30)+(9'd0*Y))+(9'd18*W))+(((U*9'd24)+(9'd29*S))+((9'd23*T)+((((P*9'd14)+((9'd7*Q)+(9'd7*R)))+((O*9'd18)+(N*9'd18)))+((((9'd16*M)+(H*9'd14))+((9'd6*I)+((((9'd12*F)+(G*9'd18))+(((E*9'd10)+(9'd0*C))+(9'd20*D)))+((9'd8*B)+(9'd4*A)))))+((9'd15*J)+((9'd30*K)+(L*9'd8))))))))+((9'd5*X)+(9'd3*V));
  wire [8:0] 
       total_weight = (((9'd10*Y)+(Z*9'd13))+(V*9'd15))+((((9'd0*W)+(9'd21*X))+(((Q*9'd23)+(9'd12*P))+(((9'd1*S)+((M*9'd8)+(N*9'd14)))+(((O*9'd22)+(((9'd5*K)+(L*9'd13))+(9'd20*I)))+(((9'd0*J)+((9'd28*F)+(9'd6*G)))+(((E*9'd27)+(9'd1*H))+((((9'd28*A)+(9'd8*B))+(9'd18*D))+(C*9'd27))))))))+(((9'd26*R)+(T*9'd22))+(9'd26*U)));
  wire [8:0] 
       total_volume = ((Z*9'd22)+(((9'd11*Y)+((((V*9'd16)+(U*9'd18))+(((9'd28*N)+(9'd30*Q))+((((9'd18*P)+(9'd19*O))+((9'd5*K)+(L*9'd2)))+(((((9'd12*I)+(9'd15*J))+((9'd20*H)+(9'd24*F)))+(((G*9'd4)+((9'd27*A)+(9'd27*B)))+(((9'd0*E)+(9'd4*D))+(C*9'd4))))+(M*9'd9)))))+(R*9'd12)))+((T*9'd13)+(9'd28*S))))+((9'd26*W)+(9'd3*X));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

