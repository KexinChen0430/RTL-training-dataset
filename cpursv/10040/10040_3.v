
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd18*W)+(Y*9'd0))+(((((U*9'd24)+(T*9'd23))+(9'd29*S))+((9'd14*P)+(Q*9'd7)))+((((R*9'd7)+((((M*9'd16)+(N*9'd18))+(((9'd18*G)+(H*9'd14))+(((9'd6*I)+((B*9'd8)+(((A*9'd4)+(D*9'd20))+(C*9'd0))))+((9'd12*F)+(9'd10*E)))))+((K*9'd30)+(9'd15*J))))+(9'd8*L))+(9'd18*O))))+((V*9'd3)+(X*9'd5));
  wire [8:0] 
       total_weight = ((((9'd10*Y)+(9'd15*V))+((T*9'd22)+(W*9'd0)))+((((9'd26*R)+(U*9'd26))+((((9'd22*O)+(P*9'd12))+((9'd8*M)+(9'd13*L)))+(((((((G*9'd6)+(F*9'd28))+(((B*9'd8)+(A*9'd28))+(((9'd27*C)+(D*9'd18))+(E*9'd27))))+(I*9'd20))+((H*9'd1)+(J*9'd0)))+(K*9'd5))+(9'd14*N))))+((S*9'd1)+(9'd23*Q))))+(X*9'd21);
  wire [8:0] 
       total_volume = (((Y*9'd11)+(X*9'd3))+(((V*9'd16)+(9'd13*T))+((((R*9'd12)+(9'd18*U))+((((9'd28*N)+(9'd30*Q))+(((9'd19*O)+(((9'd9*M)+(((9'd15*J)+(9'd12*I))+(G*9'd4)))+((((H*9'd20)+((9'd4*(D+C))+(E*9'd0)))+((B+A)*9'd27))+(9'd24*F))))+((K*9'd5)+(9'd2*L))))+(9'd18*P)))+(S*9'd28))))+(W*9'd26);

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

