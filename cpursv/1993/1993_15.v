
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd29*S)+(T*9'd23))+((P*9'd14)+(9'd18*N)))+((((9'd18*O)+(M*9'd16))+((((9'd18*G)+(I*9'd6))+((((F*9'd12)+((B*9'd8)+(9'd4*A)))+(9'd20*D))+(C*9'd0)))+((H*9'd14)+(E*9'd10))))+(((L*9'd8)+(9'd30*K))+(9'd15*J))))+((Q+R)*9'd7);
  wire [8:0] 
       total_weight = (((9'd22*T)+(R*9'd26))+((P*9'd12)+(Q*9'd23)))+(((S*9'd1)+((9'd8*M)+(9'd13*L)))+(((9'd14*N)+(9'd22*O))+((((9'd1*H)+(G*9'd6))+(((((B*9'd8)+((D*9'd18)+(9'd27*C)))+(A*9'd28))+((E*9'd27)+(F*9'd28)))+(J*9'd0)))+((K*9'd5)+(9'd20*I)))));
  wire [8:0] 
       total_volume = (((9'd12*R)+(T*9'd13))+(((Q*9'd30)+(((9'd19*O)+(9'd2*L))+(9'd28*N)))+((((9'd15*J)+(M*9'd9))+((K*9'd5)+(9'd12*I)))+((((((C*9'd4)+(E*9'd0))+(9'd27*A))+((D*9'd4)+(B*9'd27)))+((H*9'd20)+(F*9'd24)))+(9'd4*G)))))+((9'd28*S)+(P*9'd18));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

