
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((T*9'd23)+(9'd7*R))+(((Q*9'd7)+(9'd14*P))+(9'd18*N)))+((((O*9'd18)+(K*9'd30))+((((J*9'd15)+(I*9'd6))+(((B*9'd8)+(9'd0*C))+(((9'd4*A)+(9'd10*E))+(9'd20*D))))+(((9'd14*H)+(F*9'd12))+(G*9'd18))))+((9'd8*L)+(9'd16*M))))+(((U*9'd24)+(9'd3*V))+(9'd29*S));
  wire [8:0] 
       total_weight = (((U*9'd26)+(9'd15*V))+((((P*9'd12)+((Q*9'd23)+(9'd22*O)))+(((((9'd8*M)+(L*9'd13))+(N*9'd14))+((I*9'd20)+(J*9'd0)))+(((9'd5*K)+(((9'd18*D)+(9'd27*E))+(((F*9'd28)+((A*9'd28)+(B*9'd8)))+(9'd27*C))))+((G*9'd6)+(9'd1*H)))))+(9'd22*T)))+((S*9'd1)+(9'd26*R));
  wire [8:0] 
       total_volume = (((T*9'd13)+(V*9'd16))+((((P*9'd18)+(R*9'd12))+(((O*9'd19)+((((H*9'd20)+(9'd5*K))+(9'd12*I))+(((((F*9'd24)+((9'd27*A)+(9'd4*C)))+(B*9'd27))+((9'd4*D)+(9'd0*E)))+(G*9'd4))))+(((L*9'd2)+(M*9'd9))+(J*9'd15))))+((9'd30*Q)+(N*9'd28))))+((9'd28*S)+(9'd18*U));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

