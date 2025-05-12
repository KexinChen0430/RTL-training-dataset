
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd7*Q)+(T*9'd23))+((((9'd29*S)+(R*9'd7))+((N*9'd18)+(P*9'd14)))+(((M*9'd16)+(O*9'd18))+(((((K*9'd30)+(9'd6*I))+(((9'd14*H)+(G*9'd18))+((9'd4*A)+(((9'd0*C)+(D*9'd20))+(B*9'd8)))))+((F*9'd12)+(E*9'd10)))+((L*9'd8)+(J*9'd15)))));
  wire [8:0] 
       total_weight = ((((9'd26*R)+((((((L*9'd13)+(J*9'd0))+(((((B*9'd8)+((9'd27*E)+(9'd18*D)))+((A*9'd28)+(C*9'd27)))+(F*9'd28))+((9'd20*I)+(H*9'd1))))+(9'd6*G))+((K*9'd5)+(M*9'd8)))+((O*9'd22)+(9'd12*P))))+(9'd14*N))+((9'd22*T)+(9'd1*S)))+(9'd23*Q);
  wire [8:0] 
       total_volume = ((9'd30*Q)+((9'd28*S)+(9'd13*T)))+((R*9'd12)+(((9'd9*M)+((9'd18*P)+(9'd19*O)))+((((L*9'd2)+((((K*9'd5)+(J*9'd15))+(((((9'd24*F)+(9'd27*A))+(B*9'd27))+(9'd4*D))+(9'd4*C)))+((E*9'd0)+((G*9'd4)+(9'd20*H)))))+(9'd12*I))+(9'd28*N))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

