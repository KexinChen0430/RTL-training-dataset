
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd18*W)+((Y*9'd0)+(X*9'd5)))+((((U*9'd24)+(V*9'd3))+((((S*9'd29)+((O+N)*9'd18))+((((M*9'd16)+(K*9'd30))+(((9'd6*I)+(9'd18*G))+(((((C*9'd0)+(9'd10*E))+(9'd20*D))+((9'd8*B)+(A*9'd4)))+((H*9'd14)+(F*9'd12)))))+((L*9'd8)+(J*9'd15))))+((P*9'd14)+(Q*9'd7))))+(R*9'd7)))+(9'd23*T);
  wire [8:0] 
       total_weight = (((Y*9'd10)+(9'd21*X))+((T*9'd22)+(((V*9'd15)+(R*9'd26))+((Q*9'd23)+((S*9'd1)+((9'd14*N)+((((9'd12*P)+(O*9'd22))+((9'd13*L)+(M*9'd8)))+(((9'd1*H)+(((9'd20*I)+((((9'd28*F)+(G*9'd6))+((9'd28*A)+(9'd8*B)))+(9'd27*C)))+((D*9'd18)+(E*9'd27))))+((K*9'd5)+(9'd0*J))))))))))+((U*9'd26)+(9'd0*W));
  wire [8:0] 
       total_volume = (((9'd11*Y)+(9'd26*W))+((X*9'd3)+(9'd16*V)))+((9'd28*S)+((((Q*9'd30)+(9'd12*R))+((((L*9'd2)+((N*9'd28)+(9'd19*O)))+(((M*9'd9)+((((J*9'd15)+(K*9'd5))+((9'd0*E)+(9'd24*F)))+(((9'd4*G)+((C+D)*9'd4))+((B+A)*9'd27))))+((I*9'd12)+(H*9'd20))))+(P*9'd18)))+((9'd18*U)+(9'd13*T))));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

