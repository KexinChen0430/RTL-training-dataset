
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((Q+R)*9'd7)+(P*9'd14))+((((9'd16*M)+(K*9'd30))+((J*9'd15)+(9'd14*H)))+(((I*9'd6)+((D*9'd20)+(E*9'd10)))+(((9'd18*G)+(((C*9'd0)+(B*9'd8))+(9'd4*A)))+(F*9'd12)))))+((9'd18*(N+O))+(9'd8*L));
  wire [8:0] 
       total_weight = (((9'd22*O)+((9'd26*R)+(Q*9'd23)))+((M*9'd8)+(P*9'd12)))+((N*9'd14)+((((J*9'd0)+((L*9'd13)+(K*9'd5)))+(((H*9'd1)+(9'd18*D))+((((C*9'd27)+(9'd28*A))+((9'd27*E)+(B*9'd8)))+(F*9'd28))))+((G*9'd6)+(I*9'd20))));
  wire [8:0] 
       total_volume = ((((9'd30*Q)+(P*9'd18))+(9'd12*R))+((M*9'd9)+(9'd2*L)))+((((9'd28*N)+(((J*9'd15)+((9'd24*F)+(9'd20*H)))+((9'd0*E)+(((9'd4*G)+((9'd4*D)+(9'd27*B)))+((9'd4*C)+(9'd27*A))))))+((K*9'd5)+(9'd12*I)))+(O*9'd19));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

