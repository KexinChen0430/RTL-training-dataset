
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd14*P)+((Q+R)*9'd7))+(((L*9'd8)+(((9'd15*J)+(9'd30*K))+(I*9'd6)))+(((9'd18*G)+(H*9'd14))+((((9'd0*C)+(9'd4*A))+((B*9'd8)+(9'd20*D)))+((F*9'd12)+(E*9'd10))))))+(((9'd18*O)+(N*9'd18))+(9'd16*M));
  wire [8:0] 
       total_weight = ((R*9'd26)+(9'd23*Q))+((((O*9'd22)+(9'd8*M))+(9'd12*P))+((((J*9'd0)+(9'd13*L))+((((H*9'd1)+(9'd5*K))+((9'd28*F)+(I*9'd20)))+((((9'd27*E)+(9'd6*G))+((B*9'd8)+(C*9'd27)))+((9'd28*A)+(9'd18*D)))))+(N*9'd14)));
  wire [8:0] 
       total_volume = ((O*9'd19)+((R*9'd12)+(Q*9'd30)))+((9'd18*P)+((((((9'd5*K)+(9'd15*J))+(((I*9'd12)+(H*9'd20))+(9'd24*F)))+(((9'd0*E)+(G*9'd4))+(((D*9'd4)+((B*9'd27)+(A*9'd27)))+(C*9'd4))))+((9'd9*M)+(L*9'd2)))+(9'd28*N)));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

