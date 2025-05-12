
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
       total_value = ((Z*9'd30)+(((9'd5*X)+(Y*9'd0))+(W*9'd18)))+((((9'd29*S)+(Q*9'd7))+(((P*9'd14)+(R*9'd7))+((((O*9'd18)+(((9'd30*K)+(J*9'd15))+((((9'd8*B)+(9'd20*D))+((C*9'd0)+(A*9'd4)))+(((9'd10*E)+(9'd12*F))+(9'd18*G)))))+((9'd14*H)+(I*9'd6)))+((9'd8*L)+((9'd18*N)+(9'd16*M))))))+((T*9'd23)+((9'd24*U)+(9'd3*V))));
  wire [8:0] 
       total_weight = ((((Z*9'd13)+(Y*9'd10))+(9'd0*W))+((X*9'd21)+(U*9'd26)))+(((((((9'd14*N)+(K*9'd5))+((((((F*9'd28)+(9'd1*H))+(((G*9'd6)+((C*9'd27)+(9'd18*D)))+((9'd28*A)+(9'd8*B))))+(E*9'd27))+(J*9'd0))+((I*9'd20)+(9'd13*L))))+((9'd12*P)+(9'd8*M)))+((O*9'd22)+(9'd26*R)))+((9'd23*Q)+(9'd1*S)))+((9'd22*T)+(V*9'd15)));
  wire [8:0] 
       total_volume = (((9'd22*Z)+(Y*9'd11))+(X*9'd3))+(((9'd13*T)+((9'd16*V)+(W*9'd26)))+((9'd18*U)+(((9'd28*S)+(9'd30*Q))+(((9'd12*R)+((((9'd28*N)+(L*9'd2))+(J*9'd15))+((((I*9'd12)+(K*9'd5))+(((E*9'd0)+(F*9'd24))+(((G*9'd4)+((B*9'd27)+(C*9'd4)))+((A*9'd27)+(D*9'd4)))))+(H*9'd20))))+(((P*9'd18)+(9'd19*O))+(M*9'd9))))));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

