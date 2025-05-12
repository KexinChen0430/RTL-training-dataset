
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd29*S)+((Q*9'd7)+(9'd7*R)))+((((P*9'd14)+(M*9'd16))+((((9'd18*N)+(9'd18*O))+(((9'd30*K)+(((C*9'd0)+((9'd10*E)+(F*9'd12)))+(((9'd20*D)+(A*9'd4))+(B*9'd8))))+((G*9'd18)+((I*9'd6)+(9'd14*H)))))+((L*9'd8)+(J*9'd15))))+(9'd23*T));
  wire [8:0] 
       total_weight = (((S*9'd1)+(9'd22*T))+((R*9'd26)+((((O*9'd22)+(N*9'd14))+((9'd5*K)+(J*9'd0)))+((((9'd13*L)+((((H*9'd1)+(I*9'd20))+(C*9'd27))+(((9'd27*E)+(D*9'd18))+((9'd28*A)+(B*9'd8)))))+((F*9'd28)+(9'd6*G)))+(9'd8*M)))))+((Q*9'd23)+(9'd12*P));
  wire [8:0] 
       total_volume = (((R*9'd12)+(9'd13*T))+(((S*9'd28)+(((P*9'd18)+(((((9'd2*L)+(9'd5*K))+((9'd4*(G+D))+((((9'd24*F)+(9'd0*E))+(9'd4*C))+((9'd27*B)+(A*9'd27)))))+((H*9'd20)+(9'd12*I)))+(J*9'd15)))+(O*9'd19)))+((9'd28*N)+(M*9'd9))))+(Q*9'd30);

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

