
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (Y*9'd0)+((((((9'd14*P)+(9'd7*Q))+(9'd29*S))+((((((9'd30*K)+(((9'd4*A)+((9'd20*D)+(9'd8*B)))+(((9'd10*E)+(9'd0*C))+(9'd12*F))))+(((G*9'd18)+(9'd14*H))+(I*9'd6)))+(9'd15*J))+((N+O)*9'd18))+((9'd8*L)+(9'd16*M))))+((9'd7*R)+((T*9'd23)+(9'd24*U))))+(((9'd3*V)+(9'd18*W))+(9'd5*X)));
  wire [8:0] 
       total_weight = (((9'd10*Y)+((((R*9'd26)+(S*9'd1))+((((((O*9'd22)+(M*9'd8))+(9'd12*P))+((N*9'd14)+(9'd5*K)))+(((L*9'd13)+(J*9'd0))+(((F*9'd28)+(9'd6*G))+((((9'd1*H)+(9'd20*I))+((9'd27*E)+((9'd8*B)+(A*9'd28))))+((9'd18*D)+(C*9'd27))))))+(9'd23*Q)))+(V*9'd15)))+((9'd26*U)+(T*9'd22)))+((9'd0*W)+(X*9'd21));
  wire [8:0] 
       total_volume = (9'd11*Y)+(((9'd16*V)+(9'd3*X))+(((((9'd12*R)+(9'd18*U))+((S*9'd28)+(P*9'd18)))+(((Q*9'd30)+(((((9'd12*I)+(9'd5*K))+(((((9'd4*C)+(9'd27*B))+(A*9'd27))+(D*9'd4))+(9'd24*F)))+(((G*9'd4)+(E*9'd0))+(H*9'd20)))+((9'd9*M)+(9'd15*J))))+((L*9'd2)+((N*9'd28)+(O*9'd19)))))+((T*9'd13)+(9'd26*W))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

