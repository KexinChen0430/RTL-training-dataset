
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
       total_value = (((9'd18*W)+((Z*9'd30)+(9'd0*Y)))+(V*9'd3))+(((9'd5*X)+((9'd29*S)+(T*9'd23)))+(((9'd24*U)+((Q*9'd7)+(P*9'd14)))+(((R*9'd7)+((9'd15*J)+(((((9'd6*I)+(9'd30*K))+(((D*9'd20)+(((9'd0*C)+(9'd4*A))+((E*9'd10)+(B*9'd8))))+((9'd18*G)+(9'd14*H))))+(F*9'd12))+(9'd8*L))))+((9'd18*(O+N))+(9'd16*M)))));
  wire [8:0] 
       total_weight = (((9'd21*X)+(9'd13*Z))+((9'd10*Y)+(9'd15*V)))+(((9'd0*W)+((((U*9'd26)+(9'd22*T))+(R*9'd26))+((((((M*9'd8)+(((9'd20*I)+(G*9'd6))+(J*9'd0)))+(((9'd1*H)+(9'd28*F))+(((9'd27*E)+((B*9'd8)+((9'd28*A)+(C*9'd27))))+(9'd18*D))))+((9'd13*L)+(K*9'd5)))+((9'd12*P)+(9'd23*Q)))+((N*9'd14)+(O*9'd22)))))+(9'd1*S));
  wire [8:0] 
       total_volume = ((((W*9'd26)+((((9'd30*Q)+(9'd28*S))+((9'd19*O)+(9'd12*R)))+(((((L*9'd2)+(9'd9*M))+(((K*9'd5)+(((H*9'd20)+(9'd4*G))+((((C*9'd4)+(E*9'd0))+(A*9'd27))+((9'd4*D)+(B*9'd27)))))+(9'd24*F)))+((9'd15*J)+(9'd12*I)))+((P*9'd18)+(N*9'd28)))))+(V*9'd16))+((T*9'd13)+(9'd18*U)))+(((9'd11*Y)+(9'd22*Z))+(X*9'd3));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

