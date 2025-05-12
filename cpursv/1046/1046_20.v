
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (V*9'd3)+((((W*9'd18)+(9'd5*X))+((9'd29*S)+((T*9'd23)+(U*9'd24))))+((((O*9'd18)+(R*9'd7))+(Q*9'd7))+((((9'd18*N)+(9'd14*P))+(((M*9'd16)+(9'd15*J))+(((I*9'd6)+(((((9'd8*B)+(9'd0*C))+(9'd20*D))+(9'd4*A))+(9'd12*F)))+((9'd10*E)+((H*9'd14)+(G*9'd18))))))+((K*9'd30)+(L*9'd8)))));
  wire [8:0] 
       total_weight = (((9'd0*W)+(9'd21*X))+(9'd15*V))+((((9'd26*U)+(P*9'd12))+((((9'd26*R)+(Q*9'd23))+(9'd22*O))+((((9'd14*N)+(M*9'd8))+(9'd13*L))+(((9'd5*K)+(((H*9'd1)+(J*9'd0))+(9'd20*I)))+((((9'd18*D)+(E*9'd27))+((G*9'd6)+(F*9'd28)))+(((9'd27*C)+(9'd8*B))+(9'd28*A)))))))+((9'd1*S)+(9'd22*T)));
  wire [8:0] 
       total_volume = ((V*9'd16)+(9'd26*W))+(((X*9'd3)+((U*9'd18)+(9'd28*S)))+((((Q*9'd30)+(9'd19*O))+((((9'd18*P)+(9'd28*N))+(9'd2*L))+((((((9'd15*J)+(9'd12*I))+(9'd5*K))+((9'd20*H)+(9'd24*F)))+(((G*9'd4)+(((D*9'd4)+(9'd27*B))+(A*9'd27)))+((9'd0*E)+(C*9'd4))))+(9'd9*M))))+((9'd13*T)+(9'd12*R))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

