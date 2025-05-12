
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
       total_value = ((9'd30*Z)+((9'd5*X)+(W*9'd18)))+(((9'd0*Y)+((T*9'd23)+(V*9'd3)))+((((S*9'd29)+(9'd7*R))+(9'd24*U))+((((((9'd16*M)+(9'd8*L))+(J*9'd15))+((((9'd30*K)+((9'd12*F)+(9'd10*E)))+((((C*9'd0)+(D*9'd20))+((9'd8*B)+(A*9'd4)))+(G*9'd18)))+((9'd6*I)+(H*9'd14))))+(9'd7*Q))+(((P*9'd14)+(O*9'd18))+(N*9'd18)))));
  wire [8:0] 
       total_weight = ((((9'd21*X)+(9'd10*Y))+(Z*9'd13))+((((Q*9'd23)+(9'd22*T))+((R*9'd26)+((((M*9'd8)+(9'd12*P))+(O*9'd22))+((((L*9'd13)+(9'd20*I))+((((9'd1*H)+(J*9'd0))+((((9'd28*F)+(9'd6*G))+((9'd28*A)+(9'd8*B)))+((9'd27*C)+(D*9'd18))))+(E*9'd27)))+((K*9'd5)+(N*9'd14))))))+((S*9'd1)+((V*9'd15)+(U*9'd26)))))+(W*9'd0);
  wire [8:0] 
       total_volume = (((9'd22*Z)+(V*9'd16))+(((W*9'd26)+((((9'd30*Q)+(9'd28*S))+(((9'd19*O)+(L*9'd2))+((((M*9'd9)+(K*9'd5))+((G*9'd4)+((I*9'd12)+(J*9'd15))))+((9'd24*F)+((H*9'd20)+(((C*9'd4)+(E*9'd0))+((A*9'd27)+((B*9'd27)+(9'd4*D)))))))))+((9'd18*P)+(9'd28*N))))+(((U*9'd18)+(T*9'd13))+(R*9'd12))))+((Y*9'd11)+(X*9'd3));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

