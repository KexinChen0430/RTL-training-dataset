
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
       total_value = (((Z*9'd30)+(X*9'd5))+((V*9'd3)+(9'd18*W)))+((Y*9'd0)+((((9'd24*U)+(9'd23*T))+(((R*9'd7)+(P*9'd14))+(9'd29*S)))+(((N*9'd18)+(O*9'd18))+(((Q*9'd7)+((((J*9'd15)+(9'd14*H))+(9'd18*G))+(((9'd6*I)+(((9'd12*F)+(9'd10*E))+(((C*9'd0)+(B*9'd8))+(9'd4*A))))+(D*9'd20))))+(((9'd16*M)+(9'd30*K))+(L*9'd8))))));
  wire [8:0] 
       total_weight = (((9'd13*Z)+(W*9'd0))+((((((S*9'd1)+(9'd26*R))+(9'd23*Q))+((9'd22*O)+(P*9'd12)))+((((L*9'd13)+((N*9'd14)+(9'd8*M)))+(I*9'd20))+((((K*9'd5)+(J*9'd0))+(9'd6*G))+(((((B*9'd8)+(D*9'd18))+((C*9'd27)+(A*9'd28)))+(9'd1*H))+((E*9'd27)+(9'd28*F))))))+(((U*9'd26)+(T*9'd22))+(9'd15*V))))+((9'd21*X)+(Y*9'd10));
  wire [8:0] 
       total_volume = ((9'd11*Y)+((Z*9'd22)+(W*9'd26)))+((X*9'd3)+((((S*9'd28)+(9'd18*U))+(((9'd13*T)+(((Q*9'd30)+(((((K*9'd5)+(I*9'd12))+(L*9'd2))+(((J*9'd15)+(F*9'd24))+(((9'd4*G)+(((E*9'd0)+(C*9'd4))+(D*9'd4)))+((9'd27*B)+(A*9'd27)))))+(9'd20*H)))+((9'd9*M)+((O*9'd19)+(9'd28*N)))))+((P*9'd18)+(R*9'd12))))+(V*9'd16)));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

