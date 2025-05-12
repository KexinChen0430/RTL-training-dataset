
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd29*S)+(9'd23*T))+(((R*9'd7)+(9'd24*U))+(((9'd14*P)+(O*9'd18))+((((9'd18*N)+(((9'd15*J)+((M*9'd16)+(L*9'd8)))+((((F*9'd12)+((9'd14*H)+(9'd6*I)))+(((G*9'd18)+((A*9'd4)+((D*9'd20)+(9'd0*C))))+(9'd8*B)))+(9'd10*E))))+(9'd30*K))+(Q*9'd7)))))+((9'd0*Y)+(X*9'd5)))+((9'd18*W)+(9'd3*V));
  wire [8:0] 
       total_weight = ((9'd10*Y)+((V*9'd15)+(U*9'd26)))+((((9'd21*X)+((9'd26*R)+(Q*9'd23)))+(((((P*9'd12)+(((O*9'd22)+(N*9'd14))+(M*9'd8)))+((((9'd13*L)+(9'd0*J))+(I*9'd20))+(((K*9'd5)+((9'd28*F)+(9'd6*G)))+(((9'd1*H)+((9'd27*E)+(9'd18*D)))+((9'd8*B)+((A*9'd28)+(C*9'd27)))))))+(9'd1*S))+(T*9'd22)))+(9'd0*W));
  wire [8:0] 
       total_volume = (((((V*9'd16)+(9'd26*W))+(9'd18*U))+((((((N*9'd28)+(P*9'd18))+(((K*9'd5)+((((L*9'd2)+(((9'd20*H)+(9'd0*E))+(9'd4*G)))+(((9'd27*(A+B))+(D*9'd4))+((C*9'd4)+(9'd24*F))))+((9'd15*J)+(9'd12*I))))+(9'd19*O)))+(M*9'd9))+(S*9'd28))+(T*9'd13)))+((R*9'd12)+(Q*9'd30)))+((9'd3*X)+(Y*9'd11));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

