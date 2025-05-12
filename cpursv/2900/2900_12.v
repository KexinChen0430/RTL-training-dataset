
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd14*P)+(9'd8*L))+(((((9'd18*N)+(M*9'd16))+((H*9'd14)+(J*9'd15)))+((((9'd6*I)+(G*9'd18))+(9'd20*D))+((((F*9'd12)+(E*9'd10))+((A*9'd4)+(9'd0*C)))+(9'd8*B))))+(9'd30*K)))+(((O*9'd18)+(9'd7*R))+(Q*9'd7));
  wire [8:0] 
       total_weight = ((9'd12*P)+(Q*9'd23))+(((9'd26*R)+(((((M*9'd8)+(9'd14*N))+((((9'd20*I)+(9'd1*H))+((F*9'd28)+(G*9'd6)))+(((9'd18*D)+(9'd27*E))+((9'd27*C)+((9'd8*B)+(9'd28*A))))))+(J*9'd0))+((K*9'd5)+(9'd13*L))))+(9'd22*O));
  wire [8:0] 
       total_volume = ((R*9'd12)+(((9'd30*Q)+(N*9'd28))+(9'd18*P)))+((((9'd2*L)+(O*9'd19))+(M*9'd9))+(((((J*9'd15)+(9'd20*H))+((9'd24*F)+(9'd0*E)))+((9'd4*G)+(((A*9'd27)+(9'd27*B))+((D*9'd4)+(9'd4*C)))))+((9'd12*I)+(K*9'd5))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

