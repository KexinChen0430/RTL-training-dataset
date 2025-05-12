
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((U*9'd24)+(T*9'd23))+(9'd3*V))+(((9'd29*S)+(P*9'd14))+(R*9'd7)))+((((9'd18*O)+(Q*9'd7))+((M*9'd16)+(L*9'd8)))+((N*9'd18)+(((K*9'd30)+(((((E*9'd10)+((9'd8*B)+(C*9'd0)))+(A*9'd4))+((D*9'd20)+((9'd12*F)+(G*9'd18))))+(9'd15*J)))+((9'd14*H)+(9'd6*I)))));
  wire [8:0] 
       total_weight = ((9'd15*V)+(T*9'd22))+(((9'd26*U)+(R*9'd26))+((((S*9'd1)+((((9'd13*L)+(9'd22*O))+(((M*9'd8)+((H*9'd1)+(9'd20*I)))+(((G*9'd6)+(9'd0*J))+(((D*9'd18)+(((C*9'd27)+((A*9'd28)+(9'd8*B)))+(9'd28*F)))+(9'd27*E)))))+(9'd5*K)))+(N*9'd14))+((P*9'd12)+(9'd23*Q))));
  wire [8:0] 
       total_volume = (((9'd28*S)+(R*9'd12))+(((9'd18*P)+(9'd19*O))+((9'd30*Q)+(((9'd9*M)+(((9'd15*J)+(9'd5*K))+((((I*9'd12)+((D+C)*9'd4))+(((9'd24*F)+(9'd0*E))+((B*9'd27)+(A*9'd27))))+((9'd4*G)+(9'd20*H)))))+((9'd2*L)+(9'd28*N))))))+(((V*9'd16)+(U*9'd18))+(T*9'd13));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

