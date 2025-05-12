
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((W*9'd18)+(V*9'd3))+(9'd5*X))+((9'd23*T)+(9'd24*U)))+(((((9'd16*M)+(9'd14*P))+(9'd18*O))+((((9'd18*N)+(((J*9'd15)+(G*9'd18))+(((9'd14*H)+(F*9'd12))+((((9'd4*A)+(D*9'd20))+(E*9'd10))+((C*9'd0)+(B*9'd8))))))+(9'd6*I))+((L*9'd8)+(K*9'd30))))+(((9'd7*R)+(9'd29*S))+(9'd7*Q)));
  wire [8:0] 
       total_weight = (((V*9'd15)+((9'd0*W)+(X*9'd21)))+(((((S*9'd1)+(9'd26*R))+(9'd23*Q))+((((9'd22*O)+(9'd13*L))+(((H*9'd1)+((((9'd18*D)+((F*9'd28)+(G*9'd6)))+((9'd28*A)+(9'd27*E)))+((B*9'd8)+(C*9'd27))))+((9'd20*I)+(K*9'd5))))+((J*9'd0)+(M*9'd8))))+((9'd12*P)+(9'd14*N))))+((T*9'd22)+(U*9'd26));
  wire [8:0] 
       total_volume = ((X*9'd3)+(((W*9'd26)+(V*9'd16))+(9'd13*T)))+(((9'd18*U)+(((9'd18*P)+((9'd12*R)+(Q*9'd30)))+(((O*9'd19)+(N*9'd28))+((((J*9'd15)+((9'd2*L)+(9'd9*M)))+((9'd20*H)+(K*9'd5)))+(((I*9'd12)+((((C*9'd4)+(9'd24*F))+((9'd27*A)+((9'd4*D)+(B*9'd27))))+(G*9'd4)))+(9'd0*E))))))+(9'd28*S));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule

