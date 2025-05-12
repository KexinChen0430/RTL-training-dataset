
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((T*9'd23)+((((Q*9'd7)+(M*9'd16))+(((((L*9'd8)+(9'd30*K))+(9'd6*I))+(((G*9'd18)+(((H*9'd14)+(((A*9'd4)+(B*9'd8))+(9'd20*D)))+(((F*9'd12)+(9'd10*E))+(9'd0*C))))+(9'd15*J)))+(N*9'd18)))+(O*9'd18)))+((P*9'd14)+((S*9'd29)+(9'd7*R)));
  wire [8:0] 
       total_weight = (((9'd22*T)+((((9'd12*P)+((9'd8*M)+(((9'd20*I)+((9'd6*G)+(9'd1*H)))+(((((D*9'd18)+(B*9'd8))+(A*9'd28))+(((9'd28*F)+(E*9'd27))+(C*9'd27)))+(9'd0*J)))))+((K*9'd5)+(L*9'd13)))+(9'd23*Q)))+((N*9'd14)+(O*9'd22)))+((S*9'd1)+(9'd26*R));
  wire [8:0] 
       total_volume = (((T*9'd13)+(9'd12*R))+(((((O*9'd19)+(9'd9*M))+(P*9'd18))+((9'd15*J)+((I*9'd12)+(((9'd20*H)+(K*9'd5))+((((C*9'd4)+(9'd27*(B+A)))+(G*9'd4))+(((F*9'd24)+(E*9'd0))+(D*9'd4)))))))+((L*9'd2)+(9'd28*N))))+((S*9'd28)+(9'd30*Q));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

