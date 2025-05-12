
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd5*X)+((9'd18*W)+(U*9'd24)))+((((S*9'd29)+((9'd14*P)+(9'd7*Q)))+((((9'd18*O)+((L*9'd8)+(K*9'd30)))+((((9'd18*N)+(H*9'd14))+((((((9'd12*F)+(G*9'd18))+(D*9'd20))+(9'd0*C))+(((A*9'd4)+(9'd8*B))+(9'd10*E)))+((9'd15*J)+(I*9'd6))))+(9'd16*M)))+(9'd7*R)))+((9'd3*V)+(9'd23*T)));
  wire [8:0] 
       total_weight = (((9'd0*W)+(X*9'd21))+(((U*9'd26)+(9'd15*V))+(T*9'd22)))+((((S*9'd1)+((9'd13*L)+(((9'd6*G)+(((H*9'd1)+((F*9'd28)+(E*9'd27)))+(((9'd8*B)+(C*9'd27))+((9'd18*D)+(A*9'd28)))))+(((9'd5*K)+(J*9'd0))+(I*9'd20)))))+(((9'd22*O)+(9'd14*N))+(9'd8*M)))+(((R*9'd26)+(P*9'd12))+(Q*9'd23)));
  wire [8:0] 
       total_volume = (((X*9'd3)+(W*9'd26))+(((V*9'd16)+(S*9'd28))+(9'd18*U)))+((9'd13*T)+((((Q*9'd30)+(O*9'd19))+(R*9'd12))+((((9'd18*P)+(9'd28*N))+(((M*9'd9)+((((9'd15*J)+(I*9'd12))+((9'd24*F)+(E*9'd0)))+(((9'd27*B)+(((A*9'd27)+(9'd4*C))+(9'd4*D)))+(G*9'd4))))+(H*9'd20)))+((9'd5*K)+(9'd2*L)))));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

