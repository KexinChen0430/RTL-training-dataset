
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd14*P)+((((9'd18*N)+(M*9'd16))+((((9'd6*I)+(9'd18*G))+(((D*9'd20)+(E*9'd10))+(9'd12*F)))+(((9'd4*A)+(B*9'd8))+(9'd0*C))))+(((9'd14*H)+(K*9'd30))+(J*9'd15))))+(9'd8*L))+((O*9'd18)+((9'd7*R)+(9'd7*Q)));
  wire [8:0] 
       total_weight = (((P*9'd12)+(9'd26*R))+(9'd22*O))+(((9'd23*Q)+(M*9'd8))+((((((J*9'd0)+(9'd5*K))+(L*9'd13))+((((I*9'd20)+((9'd27*C)+(E*9'd27)))+((9'd28*A)+((B*9'd8)+(D*9'd18))))+(9'd1*H)))+((9'd28*F)+(G*9'd6)))+(9'd14*N)));
  wire [8:0] 
       total_volume = ((R*9'd12)+((Q*9'd30)+(P*9'd18)))+(((L*9'd2)+(9'd9*M))+((((N*9'd28)+(9'd19*O))+((9'd4*G)+(((9'd24*F)+(H*9'd20))+((((9'd4*D)+(E*9'd0))+(9'd27*A))+((9'd27*B)+(C*9'd4))))))+(((9'd5*K)+(J*9'd15))+(I*9'd12))));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule

