
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
       total_value = (9'd5*X)+((((9'd0*Y)+(9'd30*Z))+(((((V*9'd3)+(9'd18*W))+((Q*9'd7)+(R*9'd7)))+((((((O*9'd18)+(M*9'd16))+(P*9'd14))+((((9'd15*J)+(I*9'd6))+((K*9'd30)+(((((9'd10*E)+(9'd18*G))+(9'd14*H))+(F*9'd12))+((((9'd0*C)+(A*9'd4))+(B*9'd8))+(D*9'd20)))))+(9'd18*N)))+(L*9'd8))+(S*9'd29)))+(9'd23*T)))+(9'd24*U));
  wire [8:0] 
       total_weight = ((((9'd21*X)+(V*9'd15))+(9'd26*U))+(((S*9'd1)+(9'd22*T))+(((((Q*9'd23)+(R*9'd26))+(O*9'd22))+((9'd8*M)+(N*9'd14)))+(((9'd12*P)+(((9'd13*L)+(((9'd1*H)+((F*9'd28)+(E*9'd27)))+((9'd18*D)+(((9'd27*C)+(9'd28*A))+(B*9'd8)))))+(((9'd20*I)+(J*9'd0))+(G*9'd6))))+(K*9'd5)))))+((W*9'd0)+((Z*9'd13)+(Y*9'd10)));
  wire [8:0] 
       total_volume = ((9'd22*Z)+((((9'd11*Y)+(9'd3*X))+((9'd18*U)+(9'd28*S)))+((((9'd13*T)+(9'd12*R))+(9'd30*Q))+((((9'd2*L)+(N*9'd28))+(((9'd9*M)+((9'd12*I)+(9'd15*J)))+(((K*9'd5)+((9'd4*G)+(F*9'd24)))+(((E*9'd0)+(H*9'd20))+(((9'd27*B)+(9'd4*C))+((D*9'd4)+(9'd27*A)))))))+((9'd19*O)+(9'd18*P))))))+((9'd26*W)+(9'd16*V));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

