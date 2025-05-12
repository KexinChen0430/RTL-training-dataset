
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd5*X)+(9'd18*W))+((((V*9'd3)+(((9'd18*O)+(9'd14*P))+(((R*9'd7)+((((N*9'd18)+(9'd8*L))+(K*9'd30))+(((G*9'd18)+((I*9'd6)+(J*9'd15)))+(((9'd14*H)+((E*9'd10)+(9'd12*F)))+((9'd8*B)+(((9'd20*D)+(C*9'd0))+(9'd4*A)))))))+(9'd16*M))))+((Q*9'd7)+(9'd29*S)))+((U*9'd24)+(T*9'd23)));
  wire [8:0] 
       total_weight = (((V*9'd15)+((X*9'd21)+(9'd0*W)))+((9'd22*T)+(9'd1*S)))+(((U*9'd26)+((O*9'd22)+(9'd12*P)))+((((9'd26*R)+(Q*9'd23))+(((N*9'd14)+(((L*9'd13)+(((I*9'd20)+(H*9'd1))+(9'd28*F)))+((G*9'd6)+((((9'd27*C)+(9'd27*E))+(9'd28*A))+((9'd18*D)+(9'd8*B))))))+((J*9'd0)+(9'd5*K))))+(9'd8*M)));
  wire [8:0] 
       total_volume = ((X*9'd3)+((9'd13*T)+(U*9'd18)))+((((W*9'd26)+(9'd16*V))+(((P*9'd18)+(Q*9'd30))+(((((9'd28*N)+(9'd19*O))+(9'd9*M))+(((9'd5*K)+(J*9'd15))+(9'd2*L)))+((((I*9'd12)+(9'd24*F))+(9'd20*H))+(((G*9'd4)+(((B+A)*9'd27)+((D*9'd4)+(E*9'd0))))+(C*9'd4))))))+((S*9'd28)+(R*9'd12)));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule

