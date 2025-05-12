
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd3*V)+(((X*9'd5)+((S*9'd29)+(U*9'd24)))+((((9'd7*R)+(T*9'd23))+((((((L*9'd8)+(K*9'd30))+((H*9'd14)+(J*9'd15)))+(((9'd12*F)+(9'd6*I))+((((G*9'd18)+(9'd20*D))+((9'd0*C)+(9'd4*A)))+((9'd8*B)+(9'd10*E)))))+(9'd14*P))+((9'd18*N)+(9'd16*M))))+((9'd7*Q)+(9'd18*O)))))+(W*9'd18);
  wire [8:0] 
       total_weight = ((9'd21*X)+(9'd0*W))+((((9'd26*U)+(V*9'd15))+((S*9'd1)+(9'd26*R)))+(((T*9'd22)+((9'd12*P)+(9'd23*Q)))+((9'd22*O)+((((L*9'd13)+(9'd14*N))+((9'd0*J)+(9'd5*K)))+(((9'd8*M)+((G*9'd6)+(9'd20*I)))+(((9'd1*H)+(9'd18*D))+(((F*9'd28)+((9'd8*B)+((C*9'd27)+(9'd28*A))))+(9'd27*E))))))));
  wire [8:0] 
       total_volume = (((X*9'd3)+(9'd26*W))+((T*9'd13)+(9'd28*S)))+((((V*9'd16)+(U*9'd18))+(((P*9'd18)+(((((N*9'd28)+(L*9'd2))+(9'd9*M))+((J*9'd15)+(9'd12*I)))+(((9'd5*K)+(((9'd20*H)+(9'd4*G))+(((D+C)*9'd4)+((9'd27*A)+(B*9'd27)))))+((F*9'd24)+(9'd0*E)))))+(O*9'd19)))+((9'd30*Q)+(9'd12*R)));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

