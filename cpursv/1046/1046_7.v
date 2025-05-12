
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd5*X)+(T*9'd23))+((9'd29*S)+(((((O*9'd18)+(9'd7*R))+(Q*9'd7))+((((M*9'd16)+(N*9'd18))+(((J*9'd15)+(9'd8*L))+((((9'd6*I)+(9'd18*G))+((9'd12*F)+(9'd14*H)))+(((B*9'd8)+((E*9'd10)+(9'd20*D)))+((9'd0*C)+(9'd4*A))))))+(K*9'd30)))+(9'd14*P))))+(U*9'd24))+((V*9'd3)+(9'd18*W));
  wire [8:0] 
       total_weight = ((9'd0*W)+(((X*9'd21)+((((9'd26*U)+(T*9'd22))+(((((L*9'd13)+(M*9'd8))+((9'd5*K)+(J*9'd0)))+((I*9'd20)+((H*9'd1)+((((F*9'd28)+(G*9'd6))+(9'd18*D))+(((C*9'd27)+((B*9'd8)+(A*9'd28)))+(9'd27*E))))))+((Q*9'd23)+(P*9'd12))))+((9'd22*O)+(N*9'd14))))+((R*9'd26)+(S*9'd1))))+(9'd15*V);
  wire [8:0] 
       total_volume = ((9'd3*X)+((V*9'd16)+(9'd26*W)))+(((9'd12*R)+(U*9'd18))+((((T*9'd13)+(9'd28*S))+(((9'd30*Q)+(((9'd28*N)+(9'd19*O))+(9'd2*L)))+((((M*9'd9)+(9'd5*K))+(((9'd20*H)+(J*9'd15))+(9'd12*I)))+(((G*9'd4)+((((9'd27*A)+(E*9'd0))+(C*9'd4))+(B*9'd27)))+((D*9'd4)+(F*9'd24))))))+(P*9'd18)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

