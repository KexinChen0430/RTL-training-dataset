
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((P*9'd14)+(9'd7*R))+((((9'd7*Q)+(9'd18*O))+((9'd16*M)+(9'd8*L)))+(((9'd18*N)+((((G*9'd18)+(9'd15*J))+((E*9'd10)+(H*9'd14)))+(((9'd12*F)+(((C*9'd0)+(D*9'd20))+(A*9'd4)))+(B*9'd8))))+((9'd30*K)+(I*9'd6))));
  wire [8:0] 
       total_weight = ((9'd12*P)+((R*9'd26)+(Q*9'd23)))+((((((L*9'd13)+(N*9'd14))+(9'd8*M))+(I*9'd20))+(((9'd1*H)+((K*9'd5)+(9'd0*J)))+(((9'd27*E)+((G*9'd6)+(F*9'd28)))+(((D*9'd18)+(A*9'd28))+((C*9'd27)+(B*9'd8))))))+(O*9'd22));
  wire [8:0] 
       total_volume = (((Q*9'd30)+(9'd12*R))+((((9'd2*L)+(N*9'd28))+((((9'd4*G)+(9'd20*H))+(9'd0*E))+((9'd24*F)+((((B+A)*9'd27)+(9'd4*C))+(9'd4*D)))))+(((K*9'd5)+(9'd12*I))+(9'd15*J))))+(((9'd18*P)+(M*9'd9))+(O*9'd19));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

