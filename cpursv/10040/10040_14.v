
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((X*9'd5)+(9'd0*Y))+((T*9'd23)+(9'd24*U)))+(((((S*9'd29)+(((9'd18*N)+(((((M*9'd16)+(L*9'd8))+((9'd18*G)+(9'd12*F)))+((((H*9'd14)+(I*9'd6))+(E*9'd10))+(((D*9'd20)+(9'd0*C))+((B*9'd8)+(A*9'd4)))))+(J*9'd15)))+(9'd30*K)))+((9'd18*O)+(9'd14*P)))+((9'd7*R)+(9'd7*Q)))+((9'd3*V)+(W*9'd18)));
  wire [8:0] 
       total_weight = ((Y*9'd10)+((((9'd21*X)+(9'd0*W))+(9'd1*S))+((9'd22*T)+((((9'd22*O)+(P*9'd12))+((Q*9'd23)+(R*9'd26)))+(((9'd14*N)+((9'd5*K)+(L*9'd13)))+(((9'd8*M)+((9'd1*H)+(G*9'd6)))+(((I*9'd20)+(9'd0*J))+(((C*9'd27)+(((B*9'd8)+(A*9'd28))+(D*9'd18)))+((F*9'd28)+(E*9'd27))))))))))+((V*9'd15)+(U*9'd26));
  wire [8:0] 
       total_volume = (((9'd16*V)+((Y*9'd11)+(X*9'd3)))+(9'd26*W))+(((S*9'd28)+(9'd12*R))+(((9'd30*Q)+((((((I*9'd12)+(9'd20*H))+((J*9'd15)+(9'd5*K)))+((((9'd24*F)+(E*9'd0))+(G*9'd4))+((((A*9'd27)+(C*9'd4))+(9'd27*B))+(D*9'd4))))+(((9'd2*L)+(M*9'd9))+(9'd28*N)))+((P*9'd18)+(9'd19*O))))+((9'd18*U)+(T*9'd13))));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

