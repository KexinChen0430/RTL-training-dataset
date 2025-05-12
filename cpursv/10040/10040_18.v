
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((((9'd7*R)+(P*9'd14))+(9'd29*S))+((((9'd7*Q)+(K*9'd30))+((((M*9'd16)+(L*9'd8))+(((9'd15*J)+(I*9'd6))+(G*9'd18)))+(((H*9'd14)+((9'd4*A)+((D*9'd20)+(B*9'd8))))+(((F*9'd12)+(9'd10*E))+(C*9'd0)))))+((N+O)*9'd18)))+(W*9'd18))+((9'd23*T)+(U*9'd24)))+(((9'd0*Y)+(9'd5*X))+(V*9'd3));
  wire [8:0] 
       total_weight = ((Y*9'd10)+((V*9'd15)+(W*9'd0)))+(((U*9'd26)+(((((9'd1*S)+(T*9'd22))+(R*9'd26))+(((Q*9'd23)+((((J*9'd0)+(9'd8*M))+((9'd5*K)+(9'd1*H)))+(((9'd20*I)+((F*9'd28)+(E*9'd27)))+(((9'd6*G)+(((D*9'd18)+(9'd28*A))+(B*9'd8)))+(C*9'd27)))))+((9'd14*N)+(L*9'd13))))+((O*9'd22)+(P*9'd12))))+(9'd21*X));
  wire [8:0] 
       total_volume = (((9'd26*W)+(9'd11*Y))+((9'd18*U)+(9'd3*X)))+(((((S*9'd28)+(R*9'd12))+(((((9'd15*J)+(L*9'd2))+(((9'd4*G)+(C*9'd4))+((((A*9'd27)+(9'd27*B))+(D*9'd4))+(E*9'd0))))+(((H*9'd20)+(F*9'd24))+(I*9'd12)))+((9'd5*K)+((9'd28*N)+(9'd9*M)))))+((9'd19*O)+((Q*9'd30)+(P*9'd18))))+((V*9'd16)+(9'd13*T)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule

