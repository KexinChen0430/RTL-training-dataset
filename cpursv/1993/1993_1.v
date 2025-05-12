
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((T*9'd23)+(9'd29*S))+(((((9'd8*L)+(9'd18*N))+(9'd18*O))+((9'd16*M)+(((9'd30*K)+(((9'd14*H)+(J*9'd15))+(I*9'd6)))+(((((9'd0*C)+((D*9'd20)+(B*9'd8)))+(9'd4*A))+(9'd10*E))+((9'd18*G)+(9'd12*F))))))+(((9'd14*P)+(R*9'd7))+(9'd7*Q)));
  wire [8:0] 
       total_weight = (((9'd1*S)+(9'd22*T))+((9'd26*R)+(Q*9'd23)))+((((P*9'd12)+(O*9'd22))+((9'd13*L)+(K*9'd5)))+(((9'd14*N)+(M*9'd8))+((((J*9'd0)+(9'd20*I))+(((9'd27*E)+(G*9'd6))+(9'd1*H)))+(((9'd18*D)+((B*9'd8)+(A*9'd28)))+((F*9'd28)+(9'd27*C))))));
  wire [8:0] 
       total_volume = (((9'd28*S)+(T*9'd13))+((9'd18*P)+(9'd19*O)))+((((K*9'd5)+(((J*9'd15)+((((9'd27*B)+(9'd27*A))+(9'd4*(C+D)))+((9'd4*G)+(E*9'd0))))+((F*9'd24)+((9'd20*H)+(I*9'd12)))))+(((9'd9*M)+(L*9'd2))+(9'd28*N)))+((Q*9'd30)+(9'd12*R)));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

