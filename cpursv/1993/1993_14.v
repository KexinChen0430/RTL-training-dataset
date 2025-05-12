
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd29*S)+(T*9'd23))+((9'd14*P)+(Q*9'd7)))+(((9'd7*R)+((((9'd18*O)+(9'd18*N))+((L*9'd8)+(((9'd6*I)+(H*9'd14))+(((((9'd12*F)+(9'd10*E))+(9'd18*G))+((D*9'd20)+(A*9'd4)))+((B*9'd8)+(9'd0*C))))))+((9'd30*K)+(J*9'd15))))+(M*9'd16));
  wire [8:0] 
       total_weight = ((S*9'd1)+(9'd22*T))+((((9'd22*O)+((R*9'd26)+(9'd23*Q)))+(((P*9'd12)+((((9'd5*K)+(9'd20*I))+(L*9'd13))+((((9'd27*E)+((9'd1*H)+(9'd6*G)))+(D*9'd18))+(((9'd28*F)+((A*9'd28)+(C*9'd27)))+(B*9'd8)))))+(J*9'd0)))+((N*9'd14)+(M*9'd8)));
  wire [8:0] 
       total_volume = (((((T*9'd13)+(9'd28*S))+(N*9'd28))+((((9'd18*P)+(O*9'd19))+(9'd9*M))+(((9'd5*K)+((((9'd20*H)+(J*9'd15))+(((G*9'd4)+((A*9'd27)+((9'd27*B)+(D*9'd4))))+((C*9'd4)+(E*9'd0))))+(F*9'd24)))+((L*9'd2)+(9'd12*I)))))+(9'd12*R))+(9'd30*Q);

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

