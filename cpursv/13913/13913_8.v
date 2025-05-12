
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
       total_value = (((X*9'd5)+((((9'd29*S)+(U*9'd24))+((Q*9'd7)+(R*9'd7)))+((((9'd16*M)+(((9'd18*N)+(((9'd20*D)+(((F*9'd12)+(9'd8*B))+((C*9'd0)+(A*9'd4))))+((E*9'd10)+(9'd14*H))))+(((G*9'd18)+(9'd15*J))+(9'd6*I))))+((K*9'd30)+(9'd8*L)))+((O*9'd18)+(9'd14*P)))))+((9'd23*T)+((9'd3*V)+(W*9'd18))))+((Y*9'd0)+(Z*9'd30));
  wire [8:0] 
       total_weight = (((Z*9'd13)+(Y*9'd10))+(((X*9'd21)+((R*9'd26)+(9'd1*S)))+(((9'd22*T)+(U*9'd26))+(((((N*9'd14)+(9'd8*M))+(O*9'd22))+((K*9'd5)+((((9'd20*I)+(L*9'd13))+((((9'd28*F)+(9'd18*D))+(((C*9'd27)+(9'd8*B))+((9'd28*A)+(E*9'd27))))+(9'd0*J)))+((9'd1*H)+(9'd6*G)))))+((9'd12*P)+(9'd23*Q))))))+((W*9'd0)+(V*9'd15));
  wire [8:0] 
       total_volume = (((9'd3*X)+((9'd22*Z)+(9'd11*Y)))+(((((U*9'd18)+(9'd13*T))+(((Q*9'd30)+(9'd2*L))+((((N*9'd28)+(M*9'd9))+((K*9'd5)+(9'd15*J)))+(((H*9'd20)+(G*9'd4))+(((9'd12*I)+((9'd24*F)+(D*9'd4)))+(((9'd0*E)+(9'd27*B))+((A*9'd27)+(C*9'd4))))))))+((P*9'd18)+(9'd19*O)))+((9'd28*S)+(9'd12*R))))+((9'd26*W)+(V*9'd16));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

