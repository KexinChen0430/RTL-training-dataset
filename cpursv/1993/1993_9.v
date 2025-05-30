
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((T*9'd23)+(9'd7*R))+(((P*9'd14)+(9'd7*Q))+((9'd29*S)+(((9'd18*O)+(L*9'd8))+((((9'd16*M)+(9'd18*N))+((9'd6*I)+(9'd14*H)))+((((9'd15*J)+(K*9'd30))+((((9'd12*F)+(G*9'd18))+((9'd20*D)+((B*9'd8)+(9'd4*A))))+(C*9'd0)))+(E*9'd10))))));
  wire [8:0] 
       total_weight = (((T*9'd22)+(Q*9'd23))+(((P*9'd12)+(((N*9'd14)+(9'd13*L))+(9'd22*O)))+(((((9'd0*J)+(I*9'd20))+(H*9'd1))+(((F*9'd28)+((((C*9'd27)+(E*9'd27))+(B*9'd8))+(A*9'd28)))+((9'd18*D)+(9'd6*G))))+((K*9'd5)+(M*9'd8)))))+((9'd26*R)+(S*9'd1));
  wire [8:0] 
       total_volume = (T*9'd13)+(((((9'd12*R)+(9'd30*Q))+(9'd28*S))+(((9'd19*O)+(K*9'd5))+((((9'd9*M)+(9'd15*J))+((((((9'd4*C)+(A*9'd27))+(9'd27*B))+((9'd4*D)+((E*9'd0)+(9'd24*F))))+(9'd20*H))+((I*9'd12)+(9'd4*G))))+(L*9'd2))))+((9'd28*N)+(9'd18*P)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

