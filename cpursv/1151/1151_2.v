
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd24*U)+(9'd3*V))+((R*9'd7)+(T*9'd23)))+((((Q*9'd7)+(S*9'd29))+((((L*9'd8)+(9'd18*N))+(((K*9'd30)+(9'd6*I))+(9'd15*J)))+((((H*9'd14)+(9'd18*G))+(9'd12*F))+(((A*9'd4)+(9'd8*B))+(((C*9'd0)+(D*9'd20))+(9'd10*E))))))+(((P*9'd14)+(9'd18*O))+(9'd16*M)));
  wire [8:0] 
       total_weight = (((9'd15*V)+(9'd26*U))+((((P*9'd12)+(9'd1*S))+((((N*9'd14)+((9'd20*I)+(J*9'd0)))+((((9'd5*K)+(L*9'd13))+((H*9'd1)+(9'd28*F)))+((((9'd27*E)+((9'd28*A)+(9'd27*C)))+(9'd8*B))+((G*9'd6)+(9'd18*D)))))+(M*9'd8)))+((O*9'd22)+(9'd23*Q))))+((T*9'd22)+(9'd26*R));
  wire [8:0] 
       total_volume = (T*9'd13)+((((9'd18*U)+(9'd16*V))+(9'd12*R))+((Q*9'd30)+((9'd28*S)+(((((9'd19*O)+((9'd15*J)+(9'd5*K)))+((((((9'd12*I)+(H*9'd20))+((9'd4*C)+(9'd27*B)))+(((A*9'd27)+(E*9'd0))+(9'd4*D)))+(9'd4*G))+(9'd24*F)))+((9'd9*M)+(9'd2*L)))+((N*9'd28)+(P*9'd18))))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

