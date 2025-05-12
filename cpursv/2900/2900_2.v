
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd7*Q)+(R*9'd7))+(((P*9'd14)+(((9'd18*N)+(O*9'd18))+(((9'd14*H)+((((I*9'd6)+(9'd18*G))+(((A*9'd4)+(9'd8*B))+((9'd12*F)+(E*9'd10))))+((9'd0*C)+(D*9'd20))))+((K*9'd30)+(J*9'd15)))))+((M*9'd16)+(L*9'd8)));
  wire [8:0] 
       total_weight = (((P*9'd12)+(R*9'd26))+((O*9'd22)+(Q*9'd23)))+((N*9'd14)+(((9'd0*J)+(9'd5*K))+(((L*9'd13)+(M*9'd8))+(((((H*9'd1)+((9'd8*B)+((D*9'd18)+(E*9'd27))))+((9'd27*C)+(A*9'd28)))+(9'd28*F))+((9'd6*G)+(I*9'd20))))));
  wire [8:0] 
       total_volume = ((9'd12*R)+((9'd19*O)+(9'd18*P)))+(((9'd30*Q)+((((9'd12*I)+(9'd5*K))+((((9'd0*E)+(9'd24*F))+(((9'd4*D)+(C*9'd4))+((B*9'd27)+(A*9'd27))))+(H*9'd20)))+((9'd4*G)+(J*9'd15))))+(((M*9'd9)+(9'd28*N))+(L*9'd2)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

