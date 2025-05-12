
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd5*X)+(9'd18*W))+(V*9'd3))+((9'd29*S)+((U*9'd24)+(((9'd7*R)+((((P*9'd14)+(9'd7*Q))+(((9'd30*K)+(9'd18*N))+(((9'd18*G)+(H*9'd14))+((((9'd15*J)+(I*9'd6))+((((9'd8*B)+(9'd4*A))+(9'd20*D))+((9'd10*E)+(C*9'd0))))+(9'd12*F)))))+((M*9'd16)+(L*9'd8))))+(O*9'd18)))))+(9'd23*T);
  wire [8:0] 
       total_weight = ((((9'd15*V)+(X*9'd21))+(9'd0*W))+((9'd26*U)+(T*9'd22)))+((9'd26*R)+((((9'd23*Q)+(S*9'd1))+((M*9'd8)+((9'd12*P)+(9'd22*O))))+((((((9'd6*G)+((9'd27*C)+(9'd8*B)))+(((9'd18*D)+(A*9'd28))+(9'd27*E)))+(((H*9'd1)+(I*9'd20))+(9'd28*F)))+((9'd0*J)+(L*9'd13)))+((K*9'd5)+(N*9'd14)))));
  wire [8:0] 
       total_volume = ((X*9'd3)+(U*9'd18))+((((V*9'd16)+(W*9'd26))+((S*9'd28)+(R*9'd12)))+((((T*9'd13)+(((O*9'd19)+(9'd18*P))+(9'd9*M)))+((((N*9'd28)+(K*9'd5))+((9'd15*J)+(((9'd20*H)+((9'd4*D)+(E*9'd0)))+(((((9'd27*A)+(9'd27*B))+(9'd4*C))+(F*9'd24))+(9'd4*G)))))+((L*9'd2)+(I*9'd12))))+(Q*9'd30)));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

