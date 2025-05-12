
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((P*9'd14)+(Q*9'd7))+(9'd7*R))+(((((9'd30*K)+(9'd6*I))+(9'd14*H))+(((J*9'd15)+(9'd10*E))+(((((9'd18*G)+(9'd12*F))+((B*9'd8)+(9'd0*C)))+(9'd4*A))+(D*9'd20))))+(M*9'd16)))+(((L*9'd8)+(N*9'd18))+(9'd18*O));
  wire [8:0] 
       total_weight = ((((9'd26*R)+(Q*9'd23))+(9'd14*N))+((((((K*9'd5)+((D*9'd18)+(E*9'd27)))+(((A*9'd28)+((B*9'd8)+(9'd27*C)))+((G*9'd6)+(F*9'd28))))+((H*9'd1)+(9'd20*I)))+((J*9'd0)+(L*9'd13)))+((M*9'd8)+(9'd22*O))))+(9'd12*P);
  wire [8:0] 
       total_volume = (((9'd19*O)+(9'd18*P))+((Q*9'd30)+(R*9'd12)))+((((I*9'd12)+(9'd20*H))+((((K*9'd5)+(J*9'd15))+((9'd0*E)+(D*9'd4)))+((((9'd4*G)+(9'd4*C))+((9'd27*B)+(9'd27*A)))+(9'd24*F))))+(((9'd9*M)+(N*9'd28))+(L*9'd2)));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

