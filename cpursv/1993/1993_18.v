
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((R*9'd7)+(S*9'd29))+(9'd23*T))+(((P*9'd14)+(Q*9'd7))+(((9'd8*L)+(N*9'd18))+(((M*9'd16)+(J*9'd15))+((((9'd30*K)+(9'd6*I))+((((9'd14*H)+(G*9'd18))+(9'd0*C))+((D*9'd20)+((A*9'd4)+(B*9'd8)))))+((9'd10*E)+(F*9'd12)))))))+(O*9'd18);
  wire [8:0] 
       total_weight = ((9'd1*S)+(9'd22*T))+((((R*9'd26)+(Q*9'd23))+(((M*9'd8)+(9'd12*P))+(((K*9'd5)+(9'd0*J))+((9'd13*L)+((((E*9'd27)+(9'd28*F))+(((C*9'd27)+((A*9'd28)+(B*9'd8)))+(D*9'd18)))+((G*9'd6)+((I*9'd20)+(9'd1*H))))))))+((N*9'd14)+(9'd22*O)));
  wire [8:0] 
       total_volume = ((((9'd30*Q)+((((M*9'd9)+(N*9'd28))+((I*9'd12)+(J*9'd15)))+(((9'd24*F)+(G*9'd4))+(((H*9'd20)+((D*9'd4)+((B*9'd27)+(A*9'd27))))+((9'd0*E)+(C*9'd4))))))+((L*9'd2)+(K*9'd5)))+((9'd18*P)+(9'd19*O)))+(((9'd13*T)+(9'd12*R))+(9'd28*S));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule

