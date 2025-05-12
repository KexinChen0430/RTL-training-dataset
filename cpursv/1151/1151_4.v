
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((T*9'd23)+(9'd3*V))+((9'd29*S)+(U*9'd24)))+(((9'd7*(R+Q))+((((9'd18*N)+(9'd16*M))+(((9'd8*L)+(9'd6*I))+((((9'd10*E)+((G*9'd18)+(H*9'd14)))+((9'd12*F)+(9'd20*D)))+(((A*9'd4)+(C*9'd0))+(9'd8*B)))))+((J*9'd15)+(9'd30*K))))+((9'd14*P)+(O*9'd18)));
  wire [8:0] 
       total_weight = (((9'd26*U)+(9'd15*V))+((T*9'd22)+(9'd1*S)))+(((9'd22*O)+(9'd12*P))+((((9'd23*Q)+(((9'd13*L)+((((9'd1*H)+(9'd28*F))+(((9'd8*B)+(9'd28*A))+((9'd27*E)+(9'd18*D))))+(C*9'd27)))+(((J*9'd0)+(G*9'd6))+(9'd20*I))))+(((9'd14*N)+(M*9'd8))+(9'd5*K)))+(9'd26*R)));
  wire [8:0] 
       total_volume = (((9'd13*T)+(V*9'd16))+(((S*9'd28)+(Q*9'd30))+((((9'd28*N)+(O*9'd19))+((((9'd9*M)+(L*9'd2))+(((G*9'd4)+(((9'd24*F)+((9'd27*B)+((9'd27*A)+(9'd4*D))))+((9'd4*C)+(E*9'd0))))+((I*9'd12)+(9'd20*H))))+((9'd5*K)+(J*9'd15))))+((R*9'd12)+(P*9'd18)))))+(9'd18*U);

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

