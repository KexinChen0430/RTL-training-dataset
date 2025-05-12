
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd5*X)+(W*9'd18))+(9'd0*Y))+(((9'd29*S)+(R*9'd7))+(((9'd14*P)+((((((K*9'd30)+(I*9'd6))+((((9'd12*F)+(9'd14*H))+(((9'd10*E)+(B*9'd8))+((9'd0*C)+(A*9'd4))))+(D*9'd20)))+(9'd18*G))+((9'd15*J)+(M*9'd16)))+((L*9'd8)+(O*9'd18))))+((9'd18*N)+(9'd7*Q)))))+(((9'd24*U)+(9'd23*T))+(9'd3*V));
  wire [8:0] 
       total_weight = ((W*9'd0)+(9'd15*V))+((((9'd10*Y)+(9'd21*X))+((9'd22*T)+(9'd1*S)))+(((9'd26*U)+((((9'd22*O)+(9'd26*R))+(((9'd13*L)+(9'd14*N))+(((9'd5*K)+((G*9'd6)+((9'd0*J)+(9'd20*I))))+(((E*9'd27)+(9'd1*H))+((9'd28*F)+(((B*9'd8)+((9'd27*C)+(9'd18*D)))+(A*9'd28)))))))+((M*9'd8)+(P*9'd12))))+(9'd23*Q)));
  wire [8:0] 
       total_volume = (((9'd3*X)+(9'd26*W))+(9'd11*Y))+((((U*9'd18)+(S*9'd28))+(((9'd12*R)+(9'd18*P))+(((9'd19*O)+(Q*9'd30))+(((9'd28*N)+(((M*9'd9)+(((9'd20*H)+(((D+G)*9'd4)+(9'd24*F)))+(((C*9'd4)+(A*9'd27))+((B*9'd27)+(E*9'd0)))))+((I*9'd12)+(9'd15*J))))+((9'd2*L)+(9'd5*K))))))+((V*9'd16)+(T*9'd13)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

