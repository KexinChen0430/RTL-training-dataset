
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd7*R)+(T*9'd23))+((9'd29*S)+(P*9'd14)))+((O*9'd18)+(((9'd7*Q)+(((M*9'd16)+((((J*9'd15)+(K*9'd30))+((9'd12*F)+(9'd18*G)))+(((I*9'd6)+(9'd14*H))+(((E*9'd10)+(9'd0*C))+(((9'd8*B)+(D*9'd20))+(A*9'd4))))))+(9'd18*N)))+(9'd8*L)));
  wire [8:0] 
       total_weight = (((((P*9'd12)+(9'd26*R))+(((9'd0*J)+(9'd5*K))+((((I*9'd20)+((((9'd28*F)+(9'd27*C))+((9'd8*B)+(9'd28*A)))+(9'd18*D)))+(((G*9'd6)+(E*9'd27))+(9'd1*H)))+((9'd13*L)+(M*9'd8)))))+((9'd14*N)+(O*9'd22)))+((Q*9'd23)+(T*9'd22)))+(S*9'd1);
  wire [8:0] 
       total_volume = (((T*9'd13)+(R*9'd12))+(((S*9'd28)+(((((L*9'd2)+(N*9'd28))+((I*9'd12)+(J*9'd15)))+(((9'd5*K)+(H*9'd20))+(((E*9'd0)+(9'd24*F))+((9'd4*G)+((A*9'd27)+(((9'd27*B)+(9'd4*C))+(9'd4*D)))))))+((9'd9*M)+(P*9'd18))))+(9'd19*O)))+(9'd30*Q);

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

