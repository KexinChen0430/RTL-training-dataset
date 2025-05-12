
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd0*Y)+(W*9'd18))+((((9'd3*V)+(X*9'd5))+((S*9'd29)+(T*9'd23)))+(((9'd7*R)+(U*9'd24))+(((((L*9'd8)+(9'd16*M))+(((9'd18*O)+(I*9'd6))+((((K*9'd30)+(9'd15*J))+((H*9'd14)+(G*9'd18)))+(((E*9'd10)+((9'd0*C)+(9'd20*D)))+((F*9'd12)+((9'd4*A)+(B*9'd8)))))))+(N*9'd18))+((P*9'd14)+(Q*9'd7)))));
  wire [8:0] 
       total_weight = (((((9'd15*V)+(9'd22*T))+(W*9'd0))+((R*9'd26)+(9'd26*U)))+(((9'd1*S)+(((L*9'd13)+(9'd14*N))+(((M*9'd8)+(((K*9'd5)+(J*9'd0))+((((9'd28*F)+(((9'd28*A)+(9'd18*D))+(9'd27*C)))+(B*9'd8))+((G*9'd6)+(E*9'd27)))))+((9'd20*I)+(H*9'd1)))))+(((9'd22*O)+(9'd12*P))+(Q*9'd23))))+((Y*9'd10)+(X*9'd21));
  wire [8:0] 
       total_volume = (((9'd3*X)+(Y*9'd11))+(9'd16*V))+(((W*9'd26)+((((9'd13*T)+(U*9'd18))+((9'd18*P)+(Q*9'd30)))+((((N*9'd28)+(O*9'd19))+((K*9'd5)+(L*9'd2)))+((M*9'd9)+((((I*9'd12)+(9'd15*J))+(((H*9'd20)+((C*9'd4)+(A*9'd27)))+(((E*9'd0)+(B*9'd27))+(9'd4*D))))+((9'd4*G)+(F*9'd24)))))))+((9'd28*S)+(9'd12*R)));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

