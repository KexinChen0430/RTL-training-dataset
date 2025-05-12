
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((T*9'd23)+(9'd24*U))+(9'd3*V))+((((9'd29*S)+(R*9'd7))+(((((9'd16*M)+(L*9'd8))+(9'd15*J))+((9'd18*G)+((((H*9'd14)+(F*9'd12))+(((B*9'd8)+(A*9'd4))+(9'd10*E)))+((D*9'd20)+(9'd0*C)))))+((9'd30*K)+(I*9'd6))))+((9'd18*O)+(9'd18*N))))+((9'd14*P)+(9'd7*Q));
  wire [8:0] 
       total_weight = (((V*9'd15)+(T*9'd22))+(9'd26*U))+((((Q*9'd23)+(9'd1*S))+((9'd26*R)+(P*9'd12)))+((((9'd22*O)+(M*9'd8))+(N*9'd14))+(((((L*9'd13)+(9'd5*K))+(J*9'd0))+(((9'd1*H)+((9'd27*E)+(D*9'd18)))+(((9'd28*F)+(9'd28*A))+((C*9'd27)+(B*9'd8)))))+((G*9'd6)+(9'd20*I)))));
  wire [8:0] 
       total_volume = ((T*9'd13)+(V*9'd16))+((((9'd30*Q)+(9'd28*S))+((((O*9'd19)+(9'd18*P))+((9'd5*K)+(9'd2*L)))+(((9'd9*M)+(N*9'd28))+((((I*9'd12)+(9'd15*J))+((D*9'd4)+((9'd24*F)+((9'd27*A)+((C*9'd4)+(B*9'd27))))))+((E*9'd0)+((9'd20*H)+(G*9'd4)))))))+((9'd12*R)+(U*9'd18)));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

