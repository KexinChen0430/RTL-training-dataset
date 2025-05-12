
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((P*9'd14)+((((N*9'd18)+(9'd16*M))+((9'd14*H)+(9'd18*G)))+((((9'd15*J)+((((9'd0*C)+(9'd12*F))+(E*9'd10))+((B*9'd8)+(9'd4*A))))+(D*9'd20))+(I*9'd6))))+((9'd30*K)+(L*9'd8)))+(9'd7*(Q+R)))+(9'd18*O);
  wire [8:0] 
       total_weight = (((R*9'd26)+(9'd23*Q))+((9'd12*P)+(O*9'd22)))+(((((9'd13*L)+(M*9'd8))+(N*9'd14))+((9'd20*I)+((K*9'd5)+(J*9'd0))))+(((9'd1*H)+((F*9'd28)+(G*9'd6)))+(((9'd27*C)+(9'd28*A))+((B*9'd8)+((9'd27*E)+(9'd18*D))))));
  wire [8:0] 
       total_volume = ((((Q*9'd30)+(9'd18*P))+(R*9'd12))+(((O*9'd19)+(N*9'd28))+(9'd9*M)))+((((K*9'd5)+(L*9'd2))+((9'd20*H)+(((9'd4*C)+(9'd4*D))+(((B*9'd27)+(9'd27*A))+((F*9'd24)+(9'd0*E))))))+((9'd4*G)+((9'd15*J)+(I*9'd12))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

