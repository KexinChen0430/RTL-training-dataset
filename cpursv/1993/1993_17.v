
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((R*9'd7)+(9'd23*T))+((9'd14*P)+(S*9'd29)))+((((9'd7*Q)+((((((D*9'd20)+((9'd10*E)+(F*9'd12)))+((9'd4*A)+((9'd8*B)+(C*9'd0))))+((9'd6*I)+(9'd18*G)))+((9'd14*H)+((J*9'd15)+(9'd30*K))))+(9'd8*L)))+((N*9'd18)+(9'd16*M)))+(O*9'd18));
  wire [8:0] 
       total_weight = ((S*9'd1)+(T*9'd22))+(((9'd26*R)+(((P*9'd12)+(9'd14*N))+(9'd23*Q)))+(((9'd8*M)+(O*9'd22))+(((((I*9'd20)+(9'd1*H))+(((9'd27*E)+(F*9'd28))+(9'd6*G)))+(((9'd18*D)+(9'd28*A))+((9'd8*B)+(9'd27*C))))+(((9'd5*K)+(9'd13*L))+(J*9'd0)))));
  wire [8:0] 
       total_volume = (((R*9'd12)+((9'd13*T)+(S*9'd28)))+((N*9'd28)+(9'd19*O)))+(((((((I*9'd12)+(9'd24*F))+(((9'd20*H)+(G*9'd4))+(((C*9'd4)+((9'd27*A)+((B*9'd27)+(9'd4*D))))+(E*9'd0))))+((L*9'd2)+(J*9'd15)))+(M*9'd9))+(9'd5*K))+((P*9'd18)+(Q*9'd30)));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

