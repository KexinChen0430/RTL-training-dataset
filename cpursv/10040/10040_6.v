
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((((9'd29*S)+(U*9'd24))+(9'd3*V))+((((9'd23*T)+((9'd18*O)+(9'd18*N)))+(((((M*9'd16)+(L*9'd8))+(I*9'd6))+((((J*9'd15)+(K*9'd30))+(F*9'd12))+((((G*9'd18)+(9'd14*H))+(((C*9'd0)+(9'd4*A))+(B*9'd8)))+((9'd10*E)+(9'd20*D)))))+(9'd14*P)))+(Q*9'd7)))+(9'd7*R))+(((X*9'd5)+(9'd18*W))+(9'd0*Y));
  wire [8:0] 
       total_weight = (((T*9'd22)+(9'd15*V))+((((S*9'd1)+(9'd26*U))+(((Q*9'd23)+(9'd12*P))+(9'd26*R)))+((9'd8*M)+((((N*9'd14)+((I*9'd20)+(((K*9'd5)+((D*9'd18)+((9'd28*F)+(((C*9'd27)+(B*9'd8))+(9'd28*A)))))+(((9'd1*H)+(9'd6*G))+(E*9'd27)))))+((9'd0*J)+(9'd13*L)))+(O*9'd22)))))+(((9'd21*X)+(Y*9'd10))+(W*9'd0));
  wire [8:0] 
       total_volume = ((((9'd26*W)+(Y*9'd11))+(X*9'd3))+((((R*9'd12)+(T*9'd13))+((Q*9'd30)+((9'd28*S)+((((9'd18*P)+(9'd19*O))+(((((I*9'd12)+(9'd4*G))+((F*9'd24)+(9'd0*E)))+(((9'd20*H)+(D*9'd4))+(((9'd4*C)+(B*9'd27))+(9'd27*A))))+((9'd2*L)+(J*9'd15))))+(((K*9'd5)+(N*9'd28))+(9'd9*M))))))+(U*9'd18)))+(V*9'd16);

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

