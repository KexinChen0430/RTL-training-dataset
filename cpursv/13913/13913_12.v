
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
       total_value = ((9'd0*Y)+((Z*9'd30)+(9'd5*X)))+((((W*9'd18)+(9'd3*V))+(9'd23*T))+((((9'd24*U)+((P*9'd14)+(Q*9'd7)))+((((((9'd30*K)+(((H*9'd14)+(9'd18*G))+(F*9'd12)))+((9'd0*C)+((((9'd8*B)+(A*9'd4))+(E*9'd10))+(9'd20*D))))+((J*9'd15)+(9'd6*I)))+(9'd18*O))+((9'd8*L)+((9'd18*N)+(9'd16*M)))))+((R*9'd7)+(S*9'd29))));
  wire [8:0] 
       total_weight = ((9'd13*Z)+((((9'd21*X)+(((U*9'd26)+(R*9'd26))+((((9'd1*S)+(9'd23*Q))+(((((9'd13*L)+(9'd5*K))+(M*9'd8))+(9'd20*I))+((((9'd27*E)+(9'd28*F))+((((9'd1*H)+(G*9'd6))+((9'd28*A)+((C*9'd27)+(D*9'd18))))+(9'd8*B)))+(9'd0*J))))+(((9'd14*N)+(9'd22*O))+(P*9'd12)))))+(T*9'd22))+(Y*9'd10)))+((V*9'd15)+(W*9'd0));
  wire [8:0] 
       total_volume = (((Y*9'd11)+(9'd22*Z))+(9'd16*V))+((((9'd26*W)+(X*9'd3))+(((T*9'd13)+((9'd18*P)+(O*9'd19)))+((((9'd12*R)+(Q*9'd30))+(((9'd2*L)+(9'd9*M))+(9'd28*N)))+(((9'd20*H)+((J*9'd15)+(9'd5*K)))+((((I*9'd12)+(9'd24*F))+((G*9'd4)+(9'd0*E)))+(((9'd4*C)+(9'd27*A))+((D*9'd4)+(9'd27*B))))))))+((S*9'd28)+(U*9'd18)));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule

