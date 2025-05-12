
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((Y*9'd0)+(X*9'd5))+(U*9'd24))+(((((9'd23*T)+(S*9'd29))+(((((9'd18*N)+(9'd7*Q))+(((9'd18*O)+((J*9'd15)+(I*9'd6)))+(((L*9'd8)+(K*9'd30))+(((H*9'd14)+(((9'd10*E)+(C*9'd0))+((9'd4*A)+((D*9'd20)+(B*9'd8)))))+((9'd18*G)+(F*9'd12))))))+(9'd16*M))+((9'd14*P)+(9'd7*R))))+(W*9'd18))+(9'd3*V));
  wire [8:0] 
       total_weight = (((9'd15*V)+((9'd0*W)+(9'd21*X)))+(((R*9'd26)+(9'd1*S))+((((9'd22*T)+(9'd26*U))+((9'd22*O)+(9'd14*N)))+((((9'd12*P)+((((9'd8*M)+(L*9'd13))+(9'd20*I))+((((9'd0*J)+(((G*9'd6)+(C*9'd27))+(((B*9'd8)+(A*9'd28))+((E*9'd27)+(D*9'd18)))))+(F*9'd28))+(9'd1*H))))+(K*9'd5))+(9'd23*Q)))))+(9'd10*Y);
  wire [8:0] 
       total_volume = ((9'd26*W)+(Y*9'd11))+((((X*9'd3)+(9'd16*V))+(((U*9'd18)+(T*9'd13))+((((9'd19*O)+((((M*9'd9)+(((9'd20*H)+(9'd24*F))+(((9'd27*A)+(((9'd4*C)+(D*9'd4))+(9'd27*B)))+((E*9'd0)+(G*9'd4)))))+((J*9'd15)+(I*9'd12)))+((K*9'd5)+(L*9'd2))))+((9'd18*P)+(Q*9'd30)))+(N*9'd28))))+((9'd28*S)+(9'd12*R)));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule

