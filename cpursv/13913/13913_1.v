
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
       total_value = ((9'd5*X)+(9'd30*Z))+((((9'd0*Y)+(W*9'd18))+((T*9'd23)+((((U*9'd24)+(9'd7*R))+((9'd7*Q)+(S*9'd29)))+(((9'd14*P)+((((M*9'd16)+(O*9'd18))+((((J*9'd15)+(H*9'd14))+(((((9'd10*E)+(B*9'd8))+(9'd4*A))+((9'd20*D)+(C*9'd0)))+((F*9'd12)+(G*9'd18))))+(9'd6*I)))+((9'd8*L)+(K*9'd30))))+(9'd18*N)))))+(9'd3*V));
  wire [8:0] 
       total_weight = (((X*9'd21)+(9'd13*Z))+((W*9'd0)+(V*9'd15)))+(((((U*9'd26)+(9'd22*T))+(((N*9'd14)+(9'd12*P))+(((9'd22*O)+(((9'd5*K)+((9'd20*I)+(9'd6*G)))+((((B*9'd8)+((A*9'd28)+(C*9'd27)))+((E*9'd27)+(D*9'd18)))+((9'd28*F)+(H*9'd1)))))+(((L*9'd13)+(J*9'd0))+(9'd8*M)))))+(((S*9'd1)+(9'd26*R))+(9'd23*Q)))+(Y*9'd10));
  wire [8:0] 
       total_volume = (((9'd26*W)+((9'd11*Y)+(9'd22*Z)))+(V*9'd16))+((X*9'd3)+(((((S*9'd28)+(9'd18*U))+(9'd13*T))+((R*9'd12)+(Q*9'd30)))+(((P*9'd18)+(N*9'd28))+(((9'd19*O)+((((J*9'd15)+(F*9'd24))+((((H*9'd20)+(9'd4*G))+(9'd4*D))+((((C*9'd4)+(A*9'd27))+(E*9'd0))+(B*9'd27))))+(((9'd5*K)+(I*9'd12))+(L*9'd2))))+(M*9'd9)))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

