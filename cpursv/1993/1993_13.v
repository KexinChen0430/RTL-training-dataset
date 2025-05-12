
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((S*9'd29)+(R*9'd7))+(((((9'd14*P)+(O*9'd18))+(Q*9'd7))+((((9'd16*M)+(9'd18*N))+(((((I*9'd6)+((9'd0*C)+((A*9'd4)+(9'd8*B))))+(((F*9'd12)+(9'd10*E))+(D*9'd20)))+(9'd15*J))+((H*9'd14)+(9'd18*G))))+((L*9'd8)+(K*9'd30))))+(T*9'd23));
  wire [8:0] 
       total_weight = ((T*9'd22)+((9'd12*P)+(Q*9'd23)))+((((S*9'd1)+(((((9'd14*N)+((9'd0*J)+(H*9'd1)))+(((9'd20*I)+((9'd28*F)+(9'd27*E)))+((((9'd18*D)+(C*9'd27))+((A*9'd28)+(9'd8*B)))+(9'd6*G))))+(L*9'd13))+(K*9'd5)))+((9'd8*M)+(O*9'd22)))+(9'd26*R));
  wire [8:0] 
       total_volume = ((9'd13*T)+((((((9'd9*M)+(9'd2*L))+((H*9'd20)+(((G*9'd4)+(9'd24*F))+(((9'd27*A)+(C*9'd4))+(((E*9'd0)+(B*9'd27))+(D*9'd4))))))+(((K*9'd5)+(9'd12*I))+(9'd15*J)))+((9'd28*N)+(P*9'd18)))+((9'd12*R)+(O*9'd19))))+((Q*9'd30)+(9'd28*S));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

