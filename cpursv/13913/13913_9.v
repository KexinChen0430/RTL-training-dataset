
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
       total_value = ((Z*9'd30)+((Y*9'd0)+(9'd5*X)))+(((((U*9'd24)+(V*9'd3))+(W*9'd18))+((9'd23*T)+(S*9'd29)))+(((9'd7*R)+(((((((K*9'd30)+((((9'd10*E)+(9'd18*G))+((C*9'd0)+(B*9'd8)))+((9'd4*A)+(9'd20*D))))+((F*9'd12)+(H*9'd14)))+((9'd6*I)+(9'd15*J)))+(9'd18*N))+(O*9'd18))+((9'd16*M)+(L*9'd8))))+((Q*9'd7)+(P*9'd14))));
  wire [8:0] 
       total_weight = ((((Y*9'd10)+(9'd21*X))+(Z*9'd13))+(((((S*9'd1)+(9'd26*R))+(((Q*9'd23)+(((M*9'd8)+(((9'd0*J)+(K*9'd5))+((((9'd28*F)+(G*9'd6))+((9'd28*A)+((9'd18*D)+(B*9'd8))))+((9'd27*E)+(9'd27*C)))))+((9'd20*I)+(9'd1*H))))+((L*9'd13)+(N*9'd14))))+((9'd22*O)+(9'd12*P)))+(U*9'd26)))+((T*9'd22)+((W*9'd0)+(V*9'd15)));
  wire [8:0] 
       total_volume = ((((9'd22*Z)+(9'd26*W))+(9'd11*Y))+((((V*9'd16)+(S*9'd28))+((T*9'd13)+(R*9'd12)))+((((9'd28*N)+(P*9'd18))+(((M*9'd9)+(9'd2*L))+((O*9'd19)+(((((9'd24*F)+((9'd0*E)+((9'd4*C)+(9'd27*(A+B)))))+((D+G)*9'd4))+(K*9'd5))+((9'd20*H)+((9'd12*I)+(9'd15*J)))))))+(9'd30*Q))))+((X*9'd3)+(U*9'd18));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

