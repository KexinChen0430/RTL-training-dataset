
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((R+Q)*9'd7)+((((9'd14*P)+(O*9'd18))+(((K*9'd30)+(J*9'd15))+((M*9'd16)+((((((9'd20*D)+(G*9'd18))+(F*9'd12))+(E*9'd10))+((A*9'd4)+((B*9'd8)+(C*9'd0))))+((H*9'd14)+(9'd6*I))))))+(L*9'd8)))+(N*9'd18);
  wire [8:0] 
       total_weight = (((P*9'd12)+((R*9'd26)+(9'd23*Q)))+(((((((J*9'd0)+(I*9'd20))+(9'd6*G))+(((D*9'd18)+(9'd27*E))+((C*9'd27)+((B*9'd8)+(A*9'd28)))))+((9'd28*F)+(H*9'd1)))+((L*9'd13)+(9'd5*K)))+((M*9'd8)+(9'd22*O))))+(9'd14*N);
  wire [8:0] 
       total_volume = (((9'd30*Q)+(R*9'd12))+((((O*9'd19)+(9'd9*M))+(((I*9'd12)+(L*9'd2))+(9'd5*K)))+(((J*9'd15)+(((G*9'd4)+(((F*9'd24)+(9'd4*C))+(9'd0*E)))+(((D*9'd4)+(9'd27*B))+(9'd27*A))))+(H*9'd20))))+((P*9'd18)+(N*9'd28));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

