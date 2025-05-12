
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd23*T)+((((N*9'd18)+(9'd14*P))+((9'd30*K)+(((M*9'd16)+((9'd14*H)+(((J*9'd15)+(((9'd12*F)+((A*9'd4)+((C*9'd0)+(D*9'd20))))+(9'd8*B)))+((G*9'd18)+(E*9'd10)))))+(9'd6*I))))+((L*9'd8)+(9'd18*O))))+(((9'd29*S)+(R*9'd7))+(Q*9'd7)))+((9'd24*U)+(V*9'd3));
  wire [8:0] 
       total_weight = (((9'd15*V)+(9'd26*U))+(((S*9'd1)+((((O*9'd22)+(((((I*9'd20)+(9'd0*J))+(((G*9'd6)+(F*9'd28))+(9'd1*H)))+(((D*9'd18)+((9'd8*B)+(9'd27*C)))+((A*9'd28)+(9'd27*E))))+(9'd13*L)))+((M*9'd8)+(K*9'd5)))+((P*9'd12)+(9'd14*N))))+(9'd22*T)))+((9'd26*R)+(9'd23*Q));
  wire [8:0] 
       total_volume = (((9'd16*V)+(T*9'd13))+(9'd18*U))+(((((R*9'd12)+(S*9'd28))+(9'd30*Q))+(((P*9'd18)+(L*9'd2))+((((K*9'd5)+(M*9'd9))+(J*9'd15))+(((9'd4*G)+(9'd24*F))+((((9'd12*I)+(9'd20*H))+(E*9'd0))+(((C*9'd4)+(B*9'd27))+((A*9'd27)+(D*9'd4))))))))+((O*9'd19)+(N*9'd28)));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

