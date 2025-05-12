
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((V*9'd3)+(9'd24*U))+(((9'd14*P)+(Q*9'd7))+((R*9'd7)+(((((J*9'd15)+(M*9'd16))+(9'd6*I))+(((9'd30*K)+(9'd12*F))+(((G*9'd18)+(9'd14*H))+(((A*9'd4)+((E*9'd10)+(D*9'd20)))+((C*9'd0)+(B*9'd8))))))+(((N*9'd18)+(L*9'd8))+(9'd18*O))))))+(T*9'd23))+(9'd29*S);
  wire [8:0] 
       total_weight = (((9'd1*S)+((U*9'd26)+(V*9'd15)))+((R*9'd26)+(9'd23*Q)))+(((((9'd22*O)+((((((9'd28*F)+(9'd1*H))+(I*9'd20))+(((B*9'd8)+((9'd18*D)+(9'd28*A)))+(C*9'd27)))+((9'd6*G)+(E*9'd27)))+((9'd13*L)+(M*9'd8))))+((9'd0*J)+(9'd5*K)))+((9'd14*N)+(9'd12*P)))+(9'd22*T));
  wire [8:0] 
       total_volume = (((V*9'd16)+(9'd28*S))+((9'd13*T)+((((9'd30*Q)+(R*9'd12))+(P*9'd18))+(((((9'd28*N)+(((((9'd4*G)+(I*9'd12))+(9'd20*H))+((D*9'd4)+(F*9'd24)))+(((C*9'd4)+(E*9'd0))+((A+B)*9'd27))))+((9'd5*K)+(J*9'd15)))+(9'd19*O))+((9'd9*M)+(L*9'd2))))))+(9'd18*U);

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

