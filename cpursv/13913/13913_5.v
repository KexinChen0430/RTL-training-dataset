
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
       total_value = (((Z*9'd30)+(Y*9'd0))+(((9'd18*W)+(X*9'd5))+(U*9'd24)))+((((V*9'd3)+(T*9'd23))+(((S*9'd29)+(((O*9'd18)+(L*9'd8))+(((K*9'd30)+(M*9'd16))+(((((9'd20*D)+(9'd10*E))+((((9'd12*F)+(9'd18*G))+(A*9'd4))+((9'd8*B)+(9'd0*C))))+(H*9'd14))+((9'd15*J)+(9'd6*I))))))+((P*9'd14)+(9'd18*N))))+((R*9'd7)+(Q*9'd7)));
  wire [8:0] 
       total_weight = (((9'd13*Z)+((W*9'd0)+(9'd26*U)))+(((V*9'd15)+(((9'd23*Q)+(((9'd22*O)+(N*9'd14))+(9'd12*P)))+(((9'd0*J)+((M*9'd8)+(9'd13*L)))+((9'd5*K)+((((H*9'd1)+(9'd20*I))+((9'd27*E)+(D*9'd18)))+((((C*9'd27)+(9'd28*F))+((9'd8*B)+(9'd28*A)))+(9'd6*G)))))))+(((9'd1*S)+(9'd22*T))+(9'd26*R))))+((X*9'd21)+(Y*9'd10));
  wire [8:0] 
       total_volume = ((((9'd16*V)+(((9'd13*T)+(S*9'd28))+(R*9'd12)))+((((9'd19*O)+(9'd30*Q))+((N*9'd28)+(M*9'd9)))+(((P*9'd18)+(9'd5*K))+(((((9'd15*J)+(9'd20*H))+((((9'd4*D)+((9'd27*B)+(C*9'd4)))+(A*9'd27))+((9'd0*E)+(G*9'd4))))+((9'd12*I)+(9'd24*F)))+(9'd2*L)))))+((9'd18*U)+(9'd3*X)))+(((9'd22*Z)+(Y*9'd11))+(W*9'd26));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule

