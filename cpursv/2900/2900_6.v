
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd14*P)+((Q+R)*9'd7))+((9'd30*K)+((((M*9'd16)+(L*9'd8))+(((((9'd18*G)+(9'd10*E))+((9'd0*C)+(9'd20*D)))+((9'd4*A)+(B*9'd8)))+((H*9'd14)+(F*9'd12))))+((J*9'd15)+(9'd6*I)))))+((9'd18*N)+(9'd18*O));
  wire [8:0] 
       total_weight = (((9'd12*P)+(R*9'd26))+((9'd23*Q)+(9'd14*N)))+((O*9'd22)+(((9'd13*L)+(9'd8*M))+(((((K*9'd5)+((H*9'd1)+(F*9'd28)))+(((C*9'd27)+((A*9'd28)+((9'd18*D)+(B*9'd8))))+((G*9'd6)+(E*9'd27))))+(9'd20*I))+(J*9'd0))));
  wire [8:0] 
       total_volume = (((9'd30*Q)+(9'd12*R))+((((9'd28*N)+(((K*9'd5)+(9'd12*I))+(9'd2*L)))+(((G*9'd4)+(J*9'd15))+((((9'd0*E)+((B*9'd27)+(C*9'd4)))+((9'd27*A)+(D*9'd4)))+((H*9'd20)+(9'd24*F)))))+(9'd9*M)))+((9'd19*O)+(9'd18*P));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule

