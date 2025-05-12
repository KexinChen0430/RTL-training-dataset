
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd7*Q)+(P*9'd14))+(R*9'd7))+((O*9'd18)+(9'd16*M)))+((((L*9'd8)+(N*9'd18))+(((9'd30*K)+((E*9'd10)+((H*9'd14)+(9'd18*G))))+(((((9'd0*C)+(9'd8*B))+(A*9'd4))+(9'd12*F))+(9'd20*D))))+((9'd6*I)+(9'd15*J)));
  wire [8:0] 
       total_weight = ((((9'd26*R)+(9'd23*Q))+(O*9'd22))+((9'd14*N)+(9'd12*P)))+((((((H*9'd1)+(J*9'd0))+(9'd5*K))+((9'd28*F)+(I*9'd20)))+(((9'd18*D)+(9'd27*E))+((((C*9'd27)+(9'd28*A))+(9'd8*B))+(9'd6*G))))+((9'd8*M)+(9'd13*L)));
  wire [8:0] 
       total_volume = (((9'd12*R)+(9'd30*Q))+((((I*9'd12)+(L*9'd2))+(((9'd15*J)+(9'd20*H))+((((((F*9'd24)+(9'd27*B))+((9'd27*A)+(C*9'd4)))+(D*9'd4))+(9'd4*G))+(E*9'd0))))+((9'd9*M)+(9'd5*K))))+(((P*9'd18)+(N*9'd28))+(O*9'd19));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

