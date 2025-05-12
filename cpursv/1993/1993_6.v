
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd7*Q)+(9'd7*R))+((((T*9'd23)+(9'd29*S))+(((9'd16*M)+(L*9'd8))+((((O+N)*9'd18)+(9'd6*I))+((((9'd30*K)+(9'd15*J))+(((H*9'd14)+(G*9'd18))+(F*9'd12)))+(((9'd8*B)+(9'd4*A))+(((D*9'd20)+(C*9'd0))+(9'd10*E)))))))+(9'd14*P));
  wire [8:0] 
       total_weight = (((9'd26*R)+(T*9'd22))+((S*9'd1)+(Q*9'd23)))+((((N*9'd14)+((9'd22*O)+(P*9'd12)))+(M*9'd8))+((9'd13*L)+((((((9'd6*G)+(9'd0*J))+(9'd1*H))+((((9'd28*A)+(9'd8*B))+(C*9'd27))+(((9'd18*D)+(F*9'd28))+(9'd27*E))))+(K*9'd5))+(9'd20*I))));
  wire [8:0] 
       total_volume = (((9'd28*S)+((((P*9'd18)+(Q*9'd30))+((K*9'd5)+(M*9'd9)))+(((((9'd12*I)+(9'd15*J))+((E*9'd0)+(9'd24*F)))+((((G*9'd4)+(9'd20*H))+(D*9'd4))+((C*9'd4)+((9'd27*A)+(9'd27*B)))))+(L*9'd2))))+((N*9'd28)+(O*9'd19)))+((9'd13*T)+(R*9'd12));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule

