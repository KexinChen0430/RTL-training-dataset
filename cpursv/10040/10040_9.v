
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((W*9'd18)+(9'd3*V))+((X*9'd5)+(Y*9'd0)))+((((((O*9'd18)+(9'd14*P))+((9'd30*K)+(L*9'd8)))+(((M*9'd16)+((((((9'd18*G)+(9'd12*F))+(E*9'd10))+((9'd4*A)+(9'd0*C)))+((9'd20*D)+(9'd8*B)))+(((I*9'd6)+(9'd14*H))+(J*9'd15))))+(N*9'd18)))+((9'd7*Q)+(S*9'd29)))+((9'd7*R)+((9'd24*U)+(T*9'd23))));
  wire [8:0] 
       total_weight = (((9'd10*Y)+(9'd21*X))+((((((9'd26*R)+(S*9'd1))+(P*9'd12))+((N*9'd14)+(9'd23*Q)))+(((9'd22*O)+(((((9'd0*J)+(H*9'd1))+(9'd20*I))+((E*9'd27)+(((C*9'd27)+((9'd18*D)+(9'd8*B)))+(9'd28*A))))+((F*9'd28)+(9'd6*G))))+(((L*9'd13)+(9'd5*K))+(M*9'd8))))+(U*9'd26)))+(((9'd15*V)+(9'd22*T))+(9'd0*W));
  wire [8:0] 
       total_volume = (((X*9'd3)+(9'd11*Y))+((9'd18*U)+(V*9'd16)))+(((9'd26*W)+((((S*9'd28)+((P*9'd18)+(O*9'd19)))+((((9'd5*K)+(J*9'd15))+((((9'd20*H)+(9'd12*I))+(((D*9'd4)+(B*9'd27))+((C*9'd4)+(A*9'd27))))+(((9'd24*F)+(E*9'd0))+(G*9'd4))))+(((9'd9*M)+(N*9'd28))+(L*9'd2))))+(Q*9'd30)))+((9'd13*T)+(R*9'd12)));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule

