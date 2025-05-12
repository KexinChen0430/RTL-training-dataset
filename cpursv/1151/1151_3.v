
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((V*9'd3)+((9'd29*S)+(9'd7*R)))+((((9'd14*P)+((9'd18*O)+(9'd18*N)))+(((Q*9'd7)+(9'd16*M))+((((I*9'd6)+(((9'd18*G)+(((((9'd4*A)+(9'd8*B))+(C*9'd0))+(F*9'd12))+(9'd10*E)))+(D*9'd20)))+((9'd14*H)+((J*9'd15)+(K*9'd30))))+(L*9'd8))))+((T*9'd23)+(9'd24*U)));
  wire [8:0] 
       total_weight = ((((T*9'd22)+(9'd26*U))+(9'd15*V))+(((R*9'd26)+(9'd1*S))+(9'd23*Q)))+((((((L*9'd13)+(9'd8*M))+((I*9'd20)+(K*9'd5)))+(((((((9'd28*F)+(9'd8*B))+((C*9'd27)+(9'd28*A)))+(D*9'd18))+((E*9'd27)+(9'd1*H)))+(J*9'd0))+(9'd6*G)))+(9'd12*P))+((9'd14*N)+(9'd22*O)));
  wire [8:0] 
       total_volume = ((((9'd12*R)+(S*9'd28))+((9'd19*O)+(9'd28*N)))+((((9'd18*P)+(Q*9'd30))+(((I*9'd12)+((K*9'd5)+(J*9'd15)))+((((G*9'd4)+(H*9'd20))+(((9'd27*B)+(9'd4*D))+(9'd27*A)))+(((9'd24*F)+(9'd0*E))+(9'd4*C)))))+((9'd9*M)+(9'd2*L))))+(((9'd16*V)+(9'd13*T))+(9'd18*U));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

