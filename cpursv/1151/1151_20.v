
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((V*9'd3)+(((((((9'd18*N)+(9'd8*L))+(9'd16*M))+((I*9'd6)+((((C*9'd0)+(9'd20*D))+(((A*9'd4)+(B*9'd8))+(9'd12*F)))+((9'd18*G)+(E*9'd10)))))+((H*9'd14)+((K*9'd30)+(9'd15*J))))+(((9'd14*P)+(9'd7*Q))+(O*9'd18)))+((9'd7*R)+(9'd23*T))))+((U*9'd24)+(9'd29*S));
  wire [8:0] 
       total_weight = ((9'd15*V)+(((9'd26*U)+(T*9'd22))+(9'd1*S)))+((((((N*9'd14)+(9'd22*O))+(P*9'd12))+(((9'd8*M)+((((H*9'd1)+(9'd6*G))+((9'd27*C)+(9'd18*D)))+(((9'd28*F)+(E*9'd27))+((B*9'd8)+(9'd28*A)))))+(((I*9'd20)+(K*9'd5))+(J*9'd0))))+(L*9'd13))+((9'd23*Q)+(R*9'd26)));
  wire [8:0] 
       total_volume = ((U*9'd18)+((9'd13*T)+(((R*9'd12)+(9'd18*P))+(((9'd30*Q)+(((M*9'd9)+((9'd15*J)+(9'd12*I)))+(((K*9'd5)+((((9'd4*D)+(F*9'd24))+((C*9'd4)+(B*9'd27)))+(9'd27*A)))+(((H*9'd20)+(E*9'd0))+(G*9'd4)))))+(((O*9'd19)+(L*9'd2))+(9'd28*N))))))+((S*9'd28)+(V*9'd16));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

