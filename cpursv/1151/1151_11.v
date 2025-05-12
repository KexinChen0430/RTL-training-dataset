
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((Q*9'd7)+(9'd7*R))+((S*9'd29)+(((9'd14*P)+((((9'd18*N)+(O*9'd18))+((9'd8*L)+(J*9'd15)))+((((9'd18*G)+((9'd14*H)+(9'd12*F)))+(((9'd8*B)+((9'd10*E)+(9'd20*D)))+((9'd4*A)+(C*9'd0))))+((I*9'd6)+(9'd30*K)))))+(9'd16*M))))+((9'd23*T)+((9'd3*V)+(9'd24*U)));
  wire [8:0] 
       total_weight = ((9'd15*V)+(((U*9'd26)+(9'd22*T))+(S*9'd1)))+(((O*9'd22)+((((9'd8*M)+(9'd14*N))+((J*9'd0)+(K*9'd5)))+(((((9'd20*I)+(E*9'd27))+(((9'd8*B)+(C*9'd27))+((9'd28*A)+(9'd18*D))))+(((9'd6*G)+(H*9'd1))+(F*9'd28)))+(L*9'd13))))+(((9'd26*R)+(P*9'd12))+(9'd23*Q)));
  wire [8:0] 
       total_volume = ((9'd16*V)+(((((9'd9*M)+(N*9'd28))+(((P*9'd18)+((((K*9'd5)+(9'd2*L))+((9'd20*H)+(9'd4*G)))+(((I*9'd12)+((9'd4*C)+(D*9'd4)))+(((A*9'd27)+(9'd27*B))+((9'd0*E)+(F*9'd24))))))+(J*9'd15)))+((Q*9'd30)+(O*9'd19)))+(9'd28*S)))+(((9'd18*U)+(T*9'd13))+(9'd12*R));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

