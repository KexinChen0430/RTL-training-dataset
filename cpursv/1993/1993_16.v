
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd23*T)+(((((9'd18*O)+(9'd14*P))+(9'd18*N))+((K*9'd30)+(M*9'd16)))+((((L*9'd8)+(9'd6*I))+(((9'd15*J)+(((9'd4*A)+(B*9'd8))+(9'd20*D)))+(((9'd0*C)+(9'd10*E))+(F*9'd12))))+((9'd14*H)+(G*9'd18)))))+(((S*9'd29)+(9'd7*Q))+(R*9'd7));
  wire [8:0] 
       total_weight = (((T*9'd22)+(9'd1*S))+(((Q*9'd23)+(N*9'd14))+((((9'd8*M)+(O*9'd22))+(((9'd1*H)+(G*9'd6))+((((9'd20*I)+(((B*9'd8)+(9'd28*A))+(9'd18*D)))+(((9'd27*C)+(E*9'd27))+(9'd28*F)))+(9'd0*J))))+((K*9'd5)+(L*9'd13)))))+((9'd12*P)+(R*9'd26));
  wire [8:0] 
       total_volume = (((9'd28*S)+(T*9'd13))+((9'd12*R)+(Q*9'd30)))+((((O*9'd19)+(P*9'd18))+(((((((E*9'd0)+(D*9'd4))+(((B*9'd27)+(C*9'd4))+(9'd27*A)))+(F*9'd24))+((9'd4*G)+(H*9'd20)))+(9'd2*L))+((9'd15*J)+(9'd12*I))))+(((K*9'd5)+(9'd9*M))+(9'd28*N)));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

