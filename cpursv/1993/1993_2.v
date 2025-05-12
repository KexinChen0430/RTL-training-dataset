
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd29*S)+(9'd23*T))+(((9'd14*P)+(9'd7*R))+(Q*9'd7)))+((((N*9'd18)+((9'd30*K)+(9'd15*J)))+(((9'd8*L)+(9'd18*G))+((((I*9'd6)+(9'd14*H))+((((F*9'd12)+(C*9'd0))+(9'd20*D))+((A*9'd4)+(B*9'd8))))+(E*9'd10))))+((9'd18*O)+(9'd16*M)));
  wire [8:0] 
       total_weight = ((((9'd26*R)+(O*9'd22))+((((9'd0*J)+(((((((9'd28*A)+(B*9'd8))+((D*9'd18)+(E*9'd27)))+(C*9'd27))+(9'd20*I))+(((9'd28*F)+(G*9'd6))+(9'd1*H)))+(L*9'd13)))+((9'd14*N)+(9'd8*M)))+(9'd5*K)))+((Q*9'd23)+(9'd12*P)))+((S*9'd1)+(T*9'd22));
  wire [8:0] 
       total_volume = (S*9'd28)+(((T*9'd13)+(9'd12*R))+((((9'd28*N)+((9'd30*Q)+(P*9'd18)))+((((9'd9*M)+(((E*9'd0)+(9'd24*F))+(((9'd20*H)+((9'd4*C)+(9'd27*A)))+((B*9'd27)+(D*9'd4)))))+((G*9'd4)+((9'd12*I)+(9'd15*J))))+(9'd5*K)))+((L*9'd2)+(9'd19*O))));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

