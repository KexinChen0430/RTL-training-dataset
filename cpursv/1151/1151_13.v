
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((U*9'd24)+(9'd29*S))+(V*9'd3))+(9'd23*T))+(((((O*9'd18)+(Q*9'd7))+(R*9'd7))+(N*9'd18))+((((9'd30*K)+(J*9'd15))+((((9'd8*L)+(9'd16*M))+((((9'd14*H)+(I*9'd6))+((9'd4*A)+(C*9'd0)))+(((D*9'd20)+(E*9'd10))+(B*9'd8))))+((9'd12*F)+(G*9'd18))))+(P*9'd14)));
  wire [8:0] 
       total_weight = (((9'd26*R)+(9'd1*S))+((((O*9'd22)+((9'd12*P)+(9'd23*Q)))+(((((9'd0*J)+(9'd1*H))+((G*9'd6)+(I*9'd20)))+((((9'd28*F)+(E*9'd27))+((9'd28*A)+(C*9'd27)))+((D*9'd18)+(B*9'd8))))+(L*9'd13)))+((9'd5*K)+((N*9'd14)+(M*9'd8)))))+(((9'd26*U)+(9'd22*T))+(9'd15*V));
  wire [8:0] 
       total_volume = (((9'd13*T)+(((N*9'd28)+((Q*9'd30)+(P*9'd18)))+((((9'd9*M)+(9'd19*O))+((((J*9'd15)+(9'd5*K))+(9'd4*G))+((((9'd12*I)+(9'd20*H))+(D*9'd4))+((((E*9'd0)+(F*9'd24))+(9'd27*B))+((C*9'd4)+(9'd27*A))))))+(L*9'd2))))+(R*9'd12))+(((9'd28*S)+(V*9'd16))+(U*9'd18));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

