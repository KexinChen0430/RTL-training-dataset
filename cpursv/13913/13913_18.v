
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
       total_value = ((((Z*9'd30)+(X*9'd5))+(Y*9'd0))+(U*9'd24))+(((W*9'd18)+(9'd3*V))+(((((9'd23*T)+(9'd29*S))+(R*9'd7))+((9'd14*P)+(O*9'd18)))+(((Q*9'd7)+(((9'd16*M)+((J*9'd15)+(I*9'd6)))+((((E*9'd10)+((9'd14*H)+(G*9'd18)))+(((D*9'd20)+(C*9'd0))+(((9'd12*F)+(B*9'd8))+(9'd4*A))))+(K*9'd30))))+((9'd8*L)+(9'd18*N)))));
  wire [8:0] 
       total_weight = (((((9'd13*Z)+(9'd10*Y))+((((U*9'd26)+(V*9'd15))+(((R*9'd26)+((((9'd14*N)+(9'd5*K))+((9'd13*L)+(I*9'd20)))+((J*9'd0)+((((G*9'd6)+(9'd28*F))+(9'd1*H))+(((B*9'd8)+((A*9'd28)+(C*9'd27)))+((D*9'd18)+(9'd27*E)))))))+((M*9'd8)+(9'd22*O))))+((Q*9'd23)+(9'd12*P))))+((S*9'd1)+(T*9'd22)))+(9'd21*X))+(9'd0*W);
  wire [8:0] 
       total_volume = (((Y*9'd11)+(Z*9'd22))+((9'd18*U)+((9'd3*X)+(9'd26*W))))+(((V*9'd16)+(((9'd28*S)+(T*9'd13))+(9'd30*Q)))+((((R*9'd12)+(9'd18*P))+((((((F*9'd24)+((H*9'd20)+(9'd4*G)))+((C*9'd4)+(9'd4*D)))+(((9'd27*A)+(9'd0*E))+(B*9'd27)))+(((J*9'd15)+(9'd12*I))+(9'd5*K)))+(((N*9'd28)+(9'd2*L))+(M*9'd9))))+(O*9'd19)));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule

