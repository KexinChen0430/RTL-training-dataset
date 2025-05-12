
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((S*9'd29)+(V*9'd3))+(((((((9'd14*P)+(9'd7*Q))+(R*9'd7))+((9'd8*L)+(M*9'd16)))+(((((9'd14*H)+((((B*9'd8)+(A*9'd4))+((9'd20*D)+(C*9'd0)))+(F*9'd12)))+((9'd10*E)+(G*9'd18)))+(((9'd6*I)+(J*9'd15))+(9'd30*K)))+((9'd18*N)+(O*9'd18))))+(9'd23*T))+(U*9'd24));
  wire [8:0] 
       total_weight = (9'd26*U)+(((((9'd15*V)+(((((9'd12*P)+(N*9'd14))+((9'd13*L)+(9'd8*M)))+((((9'd20*I)+((J*9'd0)+(K*9'd5)))+((((9'd27*C)+(B*9'd8))+(A*9'd28))+((D*9'd18)+(F*9'd28))))+((9'd27*E)+((G*9'd6)+(9'd1*H)))))+((9'd26*R)+(9'd22*O))))+(Q*9'd23))+(T*9'd22))+(9'd1*S));
  wire [8:0] 
       total_volume = ((((U*9'd18)+(9'd13*T))+(9'd16*V))+(((9'd28*S)+(9'd12*R))+(((M*9'd9)+(9'd2*L))+(((O*9'd19)+(9'd28*N))+((((9'd12*I)+(9'd24*F))+(((D*9'd4)+(E*9'd0))+((G*9'd4)+((B*9'd27)+((9'd4*C)+(A*9'd27))))))+(((J*9'd15)+(9'd20*H))+(K*9'd5)))))))+((P*9'd18)+(Q*9'd30));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

