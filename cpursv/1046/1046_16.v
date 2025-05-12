
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((X*9'd5)+(W*9'd18))+(((9'd23*T)+(9'd24*U))+(V*9'd3)))+(((S*9'd29)+((Q*9'd7)+(9'd14*P)))+((9'd7*R)+(((9'd8*L)+(9'd16*M))+((((O*9'd18)+(N*9'd18))+(((9'd30*K)+((G*9'd18)+((H*9'd14)+(I*9'd6))))+((((F*9'd12)+(9'd20*D))+(C*9'd0))+(((A*9'd4)+(E*9'd10))+(9'd8*B)))))+(J*9'd15)))));
  wire [8:0] 
       total_weight = ((9'd21*X)+(W*9'd0))+((((9'd26*U)+((((9'd26*R)+(S*9'd1))+((9'd13*L)+((9'd14*N)+(((((9'd5*K)+(J*9'd0))+(I*9'd20))+(((((A*9'd28)+(9'd8*B))+(9'd27*C))+((9'd6*G)+(9'd28*F)))+((D*9'd18)+(E*9'd27))))+(H*9'd1)))))+(((9'd8*M)+(P*9'd12))+(9'd22*O))))+(Q*9'd23))+((T*9'd22)+(9'd15*V)));
  wire [8:0] 
       total_volume = (((((9'd3*X)+(9'd26*W))+(((((P*9'd18)+(9'd30*Q))+(9'd19*O))+((((M*9'd9)+(9'd28*N))+(((9'd4*G)+((J*9'd15)+(I*9'd12)))+((((B*9'd27)+((9'd27*A)+(9'd4*D)))+(9'd4*C))+((9'd24*F)+(9'd0*E)))))+(H*9'd20)))+((9'd5*K)+(L*9'd2))))+(((9'd12*R)+(9'd13*T))+(9'd28*S)))+(9'd16*V))+(U*9'd18);

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

