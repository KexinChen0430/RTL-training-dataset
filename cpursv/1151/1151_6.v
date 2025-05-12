
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((V*9'd3)+(9'd24*U))+(9'd23*T))+((((S*9'd29)+(9'd7*R))+((9'd8*L)+(9'd16*M)))+((((O*9'd18)+((I*9'd6)+(J*9'd15)))+(((K*9'd30)+(((9'd18*G)+(9'd14*H))+((D*9'd20)+(((B*9'd8)+(9'd4*A))+(9'd0*C)))))+((9'd12*F)+(E*9'd10))))+(9'd18*N))))+((9'd14*P)+(9'd7*Q));
  wire [8:0] 
       total_weight = (U*9'd26)+((((9'd22*T)+(9'd15*V))+((9'd23*Q)+(((M*9'd8)+(L*9'd13))+((((9'd14*N)+(O*9'd22))+((9'd0*J)+(I*9'd20)))+(((9'd5*K)+((F*9'd28)+(9'd6*G)))+(((9'd1*H)+((E*9'd27)+((9'd28*A)+(B*9'd8))))+((C*9'd27)+(D*9'd18))))))))+(((9'd26*R)+(P*9'd12))+(9'd1*S)));
  wire [8:0] 
       total_volume = ((((S*9'd28)+((9'd19*O)+(9'd9*M)))+((((9'd5*K)+(9'd28*N))+(9'd2*L))+((((H*9'd20)+(J*9'd15))+(9'd12*I))+(((D*9'd4)+((9'd4*G)+(9'd24*F)))+(((C*9'd4)+(A*9'd27))+((B*9'd27)+(E*9'd0)))))))+((P*9'd18)+((Q*9'd30)+(R*9'd12))))+(((V*9'd16)+(U*9'd18))+(T*9'd13));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule

