
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((X*9'd5)+(Y*9'd0))+(9'd18*W))+(((9'd3*V)+(9'd24*U))+(9'd23*T)))+((((((9'd29*S)+(R*9'd7))+((O*9'd18)+(N*9'd18)))+((((9'd16*M)+(((9'd15*J)+((((9'd12*F)+(G*9'd18))+(C*9'd0))+((9'd8*B)+(9'd4*A))))+((9'd20*D)+(E*9'd10))))+((I*9'd6)+(9'd14*H)))+((L*9'd8)+(9'd30*K))))+(P*9'd14))+(9'd7*Q));
  wire [8:0] 
       total_weight = (((9'd26*U)+(9'd22*T))+(((9'd0*W)+((((((9'd13*L)+(9'd14*N))+(K*9'd5))+(((9'd8*M)+(((J*9'd0)+((E*9'd27)+(F*9'd28)))+(((((C*9'd27)+(A*9'd28))+((9'd8*B)+(D*9'd18)))+(H*9'd1))+(G*9'd6))))+(9'd20*I)))+(9'd22*O))+(P*9'd12)))+(((Q*9'd23)+(9'd26*R))+(9'd1*S))))+(((9'd15*V)+(X*9'd21))+(Y*9'd10));
  wire [8:0] 
       total_volume = (((9'd11*Y)+(9'd26*W))+((((U*9'd18)+(T*9'd13))+((9'd30*Q)+(R*9'd12)))+(((S*9'd28)+(9'd19*O))+(((P*9'd18)+(((9'd2*L)+((I*9'd12)+(H*9'd20)))+(((9'd15*J)+((9'd0*E)+(9'd24*F)))+(((((C*9'd4)+(9'd27*A))+(B*9'd27))+(9'd4*G))+(D*9'd4)))))+((K*9'd5)+((N*9'd28)+(M*9'd9)))))))+((9'd16*V)+(9'd3*X));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

