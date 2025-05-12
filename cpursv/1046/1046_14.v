
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((((S*9'd29)+(9'd24*U))+((9'd7*R)+(Q*9'd7)))+((((((9'd18*O)+(M*9'd16))+(N*9'd18))+(((9'd15*J)+(9'd30*K))+(((I*9'd6)+(9'd8*L))+((((9'd18*G)+(((9'd0*C)+(B*9'd8))+((9'd20*D)+(A*9'd4))))+(9'd14*H))+((9'd12*F)+(9'd10*E))))))+(P*9'd14))+(9'd23*T)))+(9'd18*W))+((9'd5*X)+(9'd3*V));
  wire [8:0] 
       total_weight = (X*9'd21)+(((9'd0*W)+(T*9'd22))+(((S*9'd1)+((U*9'd26)+(V*9'd15)))+((((9'd12*P)+(9'd26*R))+(Q*9'd23))+((9'd14*N)+((((L*9'd13)+(9'd22*O))+(((M*9'd8)+((G*9'd6)+(9'd20*I)))+((((F*9'd28)+(9'd1*H))+((E*9'd27)+((9'd28*A)+(B*9'd8))))+((9'd27*C)+(D*9'd18)))))+((9'd0*J)+(9'd5*K)))))));
  wire [8:0] 
       total_volume = ((U*9'd18)+(X*9'd3))+((((W*9'd26)+(9'd12*R))+((((9'd18*P)+(9'd30*Q))+((O*9'd19)+(((9'd9*M)+((L*9'd2)+(N*9'd28)))+((((9'd20*H)+(9'd5*K))+((((F*9'd24)+(G*9'd4))+(((A+B)*9'd27)+((C*9'd4)+(E*9'd0))))+(D*9'd4)))+((9'd12*I)+(9'd15*J))))))+((9'd13*T)+(9'd28*S))))+(9'd16*V));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

