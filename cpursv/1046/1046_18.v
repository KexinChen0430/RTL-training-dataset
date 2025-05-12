
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd5*X)+(W*9'd18))+(V*9'd3))+(((R*9'd7)+(9'd24*U))+(9'd23*T)))+((((((P*9'd14)+(9'd16*M))+(O*9'd18))+(((N*9'd18)+(J*9'd15))+((((9'd6*I)+((G*9'd18)+(F*9'd12)))+(((C*9'd0)+(B*9'd8))+((A*9'd4)+((9'd20*D)+(E*9'd10)))))+(H*9'd14))))+((9'd30*K)+(L*9'd8)))+((Q*9'd7)+(9'd29*S)));
  wire [8:0] 
       total_weight = (((9'd21*X)+(W*9'd0))+((T*9'd22)+((9'd15*V)+(9'd26*U))))+(((((R*9'd26)+(9'd1*S))+(((N*9'd14)+(9'd8*M))+(((9'd22*O)+((9'd5*K)+(9'd13*L)))+((((J*9'd0)+((((B*9'd8)+(9'd27*C))+(9'd27*E))+(9'd28*A)))+((F*9'd28)+(D*9'd18)))+(((G*9'd6)+(I*9'd20))+(9'd1*H))))))+(9'd23*Q))+(9'd12*P));
  wire [8:0] 
       total_volume = ((U*9'd18)+(((((S*9'd28)+(9'd12*R))+(((9'd30*Q)+((M*9'd9)+(9'd2*L)))+((N*9'd28)+(((I*9'd12)+(J*9'd15))+(((9'd5*K)+((9'd24*F)+((9'd4*G)+(H*9'd20))))+(((C*9'd4)+((9'd4*D)+(9'd0*E)))+((B*9'd27)+(9'd27*A))))))))+((9'd18*P)+(9'd19*O)))+(T*9'd13)))+((V*9'd16)+((9'd26*W)+(X*9'd3)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

