
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
       total_value = (((W*9'd18)+((9'd30*Z)+(9'd0*Y)))+((9'd5*X)+(9'd3*V)))+((T*9'd23)+((((9'd24*U)+((((9'd14*P)+(9'd7*Q))+(((9'd8*L)+(9'd30*K))+(((J*9'd15)+((((H*9'd14)+((D*9'd20)+(9'd12*F)))+((E*9'd10)+(((C*9'd0)+(9'd4*A))+(B*9'd8))))+(I*9'd6)))+(G*9'd18))))+(M*9'd16)))+((O*9'd18)+(9'd18*N)))+((9'd7*R)+(S*9'd29))));
  wire [8:0] 
       total_weight = ((((Z*9'd13)+(9'd10*Y))+(W*9'd0))+(9'd15*V))+(((9'd21*X)+(((R*9'd26)+(9'd22*T))+(9'd26*U)))+(((P*9'd12)+(9'd23*Q))+(((9'd1*S)+(9'd14*N))+((((9'd8*M)+(9'd22*O))+(((I*9'd20)+(K*9'd5))+(((9'd0*J)+((9'd28*F)+(E*9'd27)))+((((9'd6*G)+(H*9'd1))+((B*9'd8)+(A*9'd28)))+((D*9'd18)+(C*9'd27))))))+(L*9'd13)))));
  wire [8:0] 
       total_volume = ((((Y*9'd11)+(9'd3*X))+(Z*9'd22))+((W*9'd26)+(V*9'd16)))+((((9'd18*U)+(S*9'd28))+(R*9'd12))+((((T*9'd13)+((((M*9'd9)+(I*9'd12))+((((9'd20*H)+(J*9'd15))+((G*9'd4)+(F*9'd24)))+(((D*9'd4)+((9'd27*A)+(9'd27*B)))+((E*9'd0)+(C*9'd4)))))+((K*9'd5)+(9'd2*L))))+((N*9'd28)+((9'd19*O)+(P*9'd18))))+(9'd30*Q)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

