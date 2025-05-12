
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((S*9'd29)+(Q*9'd7))+(9'd23*T))+((((R*9'd7)+(O*9'd18))+(((((L*9'd8)+(9'd16*M))+((9'd14*H)+(((G*9'd18)+((((E*9'd10)+(9'd0*C))+((B*9'd8)+(9'd4*A)))+(F*9'd12)))+(9'd20*D))))+((I*9'd6)+((9'd15*J)+(9'd30*K))))+(9'd14*P)))+(9'd18*N));
  wire [8:0] 
       total_weight = (((9'd23*Q)+(((9'd12*P)+(((N*9'd14)+(K*9'd5))+(9'd8*M)))+((((9'd13*L)+(((9'd20*I)+(((B*9'd8)+(C*9'd27))+((9'd28*A)+(E*9'd27))))+((9'd28*F)+(9'd18*D))))+((9'd6*G)+(H*9'd1)))+(9'd0*J))))+(9'd22*O))+(((R*9'd26)+(9'd1*S))+(T*9'd22));
  wire [8:0] 
       total_volume = (((9'd28*S)+(T*9'd13))+((((R*9'd12)+(Q*9'd30))+(((((G*9'd4)+(((9'd20*H)+((C*9'd4)+((D*9'd4)+(E*9'd0))))+((A+B)*9'd27)))+(9'd24*F))+((9'd15*J)+(I*9'd12)))+(L*9'd2)))+(((M*9'd9)+(K*9'd5))+(N*9'd28))))+((9'd19*O)+(P*9'd18));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

