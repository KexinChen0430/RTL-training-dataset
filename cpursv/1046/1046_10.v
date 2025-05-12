
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((X*9'd5)+(9'd18*W))+(((((O*9'd18)+((9'd16*M)+(N*9'd18)))+(((9'd14*P)+((J*9'd15)+(9'd30*K)))+((9'd8*L)+(((((9'd6*I)+(H*9'd14))+((9'd20*D)+(E*9'd10)))+((9'd12*F)+(((C*9'd0)+(9'd8*B))+(9'd4*A))))+(G*9'd18)))))+((Q*9'd7)+((9'd29*S)+(R*9'd7))))+((V*9'd3)+(U*9'd24))))+(T*9'd23);
  wire [8:0] 
       total_weight = ((((9'd0*W)+(X*9'd21))+(V*9'd15))+(T*9'd22))+((((9'd1*S)+(9'd26*R))+(U*9'd26))+((((9'd14*N)+(((9'd8*M)+((9'd20*I)+(H*9'd1)))+((((J*9'd0)+(9'd5*K))+(((G*9'd6)+(9'd28*F))+((D*9'd18)+((A*9'd28)+((9'd27*C)+(9'd8*B))))))+(E*9'd27))))+(9'd13*L))+(((9'd22*O)+(P*9'd12))+(Q*9'd23))));
  wire [8:0] 
       total_volume = ((W*9'd26)+(((9'd3*X)+((((S*9'd28)+(9'd13*T))+(((M*9'd9)+(9'd2*L))+((((9'd5*K)+((((9'd0*E)+(9'd4*G))+(((B*9'd27)+(D*9'd4))+(9'd27*A)))+(9'd4*C)))+((9'd24*F)+(9'd20*H)))+((9'd12*I)+(J*9'd15)))))+(((P*9'd18)+(N*9'd28))+(9'd19*O))))+((Q*9'd30)+(9'd12*R))))+((U*9'd18)+(V*9'd16));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

