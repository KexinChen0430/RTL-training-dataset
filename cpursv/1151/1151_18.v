
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd3*V)+(9'd23*T))+(9'd24*U))+((9'd7*Q)+(S*9'd29)))+(((9'd7*R)+(((N*9'd18)+((((I*9'd6)+(F*9'd12))+((((9'd18*G)+(D*9'd20))+((9'd10*E)+((9'd8*B)+(A*9'd4))))+(9'd0*C)))+(((K*9'd30)+(J*9'd15))+(H*9'd14))))+(L*9'd8)))+(((P*9'd14)+(9'd16*M))+(9'd18*O)));
  wire [8:0] 
       total_weight = (((9'd22*T)+(V*9'd15))+(((U*9'd26)+(P*9'd12))+((((L*9'd13)+(9'd5*K))+(((N*9'd14)+(9'd8*M))+((((H*9'd1)+(9'd0*J))+((((9'd8*B)+(9'd28*A))+((D*9'd18)+(9'd27*C)))+((9'd6*G)+(E*9'd27))))+((9'd28*F)+(I*9'd20)))))+((Q*9'd23)+(O*9'd22)))))+((9'd26*R)+(9'd1*S));
  wire [8:0] 
       total_volume = (((9'd16*V)+(9'd18*U))+((((9'd12*R)+(O*9'd19))+((9'd18*P)+(N*9'd28)))+(((9'd9*M)+((((H*9'd20)+(J*9'd15))+(9'd0*E))+(((9'd4*G)+(F*9'd24))+((D*9'd4)+(((9'd27*A)+(9'd27*B))+(C*9'd4))))))+(((9'd5*K)+(L*9'd2))+(I*9'd12)))))+(((Q*9'd30)+(9'd28*S))+(9'd13*T));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

