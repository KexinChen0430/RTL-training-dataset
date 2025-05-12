
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd7*R)+(P*9'd14))+((((((9'd8*L)+((I*9'd6)+(G*9'd18)))+(((H*9'd14)+((9'd10*E)+(9'd12*F)))+(((9'd0*C)+((B*9'd8)+(9'd4*A)))+(D*9'd20))))+(M*9'd16))+((9'd30*K)+(J*9'd15)))+(N*9'd18)))+((O*9'd18)+(9'd7*Q));
  wire [8:0] 
       total_weight = ((O*9'd22)+(9'd26*R))+((((Q*9'd23)+(P*9'd12))+((N*9'd14)+(9'd8*M)))+((((9'd20*I)+((9'd5*K)+(L*9'd13)))+(9'd1*H))+(((9'd0*J)+(((9'd27*C)+(9'd18*D))+(((9'd27*E)+(9'd28*A))+(B*9'd8))))+((9'd28*F)+(9'd6*G)))));
  wire [8:0] 
       total_volume = ((((Q*9'd30)+(9'd12*R))+(9'd19*O))+((P*9'd18)+(9'd9*M)))+((((9'd28*N)+(L*9'd2))+((((9'd12*I)+(9'd5*K))+(((9'd20*H)+(9'd4*G))+(9'd0*E)))+(((D*9'd4)+(9'd4*C))+(((F*9'd24)+(9'd27*B))+(A*9'd27)))))+(J*9'd15));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

