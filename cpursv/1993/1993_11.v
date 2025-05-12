
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd7*R)+(9'd23*T))+(((9'd18*N)+(Q*9'd7))+((O*9'd18)+((((9'd30*K)+((9'd16*M)+(L*9'd8)))+(((J*9'd15)+(((9'd8*B)+((A*9'd4)+(9'd20*D)))+((F*9'd12)+(C*9'd0))))+(((9'd14*H)+(9'd10*E))+(9'd18*G))))+(9'd6*I)))))+((9'd14*P)+(9'd29*S));
  wire [8:0] 
       total_weight = (((9'd23*Q)+(9'd22*T))+(9'd1*S))+(((P*9'd12)+(9'd26*R))+(((((9'd5*K)+(I*9'd20))+((((9'd1*H)+(G*9'd6))+(((F*9'd28)+(9'd27*E))+((9'd8*B)+(9'd28*A))))+((9'd27*C)+(9'd18*D))))+((9'd0*J)+(L*9'd13)))+((9'd8*M)+((9'd22*O)+(N*9'd14)))));
  wire [8:0] 
       total_volume = (((9'd13*T)+(9'd28*S))+((((Q*9'd30)+(((J*9'd15)+(M*9'd9))+((((9'd12*I)+((((9'd4*G)+((9'd27*A)+(C*9'd4)))+((B*9'd27)+(9'd4*D)))+(9'd0*E)))+(9'd24*F))+((9'd5*K)+(H*9'd20)))))+(((N*9'd28)+(O*9'd19))+(L*9'd2)))+(R*9'd12)))+(9'd18*P);

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

