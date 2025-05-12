
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((T*9'd23)+(S*9'd29))+((9'd14*P)+(9'd7*Q)))+(((((O*9'd18)+(((9'd15*J)+(K*9'd30))+(((9'd16*M)+(((H*9'd14)+(9'd12*F))+(((C*9'd0)+((9'd4*A)+((9'd20*D)+(9'd8*B))))+(9'd10*E))))+((9'd18*G)+(9'd6*I)))))+(L*9'd8))+(9'd18*N))+(9'd7*R));
  wire [8:0] 
       total_weight = ((T*9'd22)+((((O*9'd22)+(L*9'd13))+((((N*9'd14)+(9'd8*M))+(9'd0*J))+(((((G*9'd6)+(9'd20*I))+((((9'd28*F)+(9'd27*C))+(9'd27*E))+((A*9'd28)+((D*9'd18)+(9'd8*B)))))+(9'd1*H))+(9'd5*K))))+((R*9'd26)+(S*9'd1))))+((9'd12*P)+(9'd23*Q));
  wire [8:0] 
       total_volume = ((9'd13*T)+(9'd12*R))+(((((M*9'd9)+(N*9'd28))+(((L*9'd2)+((9'd20*H)+((9'd5*K)+(9'd15*J))))+((((I*9'd12)+(9'd24*F))+(((9'd4*G)+((9'd4*D)+(A*9'd27)))+((9'd4*C)+(9'd27*B))))+(9'd0*E))))+((9'd18*P)+(9'd19*O)))+((9'd30*Q)+(S*9'd28)));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

