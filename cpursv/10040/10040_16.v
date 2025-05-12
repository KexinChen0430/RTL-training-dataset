
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd18*W)+(9'd0*Y))+(V*9'd3))+(((9'd5*X)+(T*9'd23))+(((9'd24*U)+((((S*9'd29)+((((K*9'd30)+(L*9'd8))+((9'd16*M)+(9'd18*N)))+((((9'd14*H)+((9'd6*I)+(9'd15*J)))+((((B*9'd8)+(A*9'd4))+((9'd0*C)+(9'd20*D)))+((F*9'd12)+(G*9'd18))))+(9'd10*E))))+((9'd18*O)+(P*9'd14)))+(9'd7*R)))+(Q*9'd7)));
  wire [8:0] 
       total_weight = (((X*9'd21)+(Y*9'd10))+(V*9'd15))+(((U*9'd26)+(W*9'd0))+(((9'd1*S)+(9'd22*T))+((((R*9'd26)+((9'd22*O)+(9'd14*N)))+(((((M*9'd8)+(L*9'd13))+(9'd5*K))+(((((G*9'd6)+(9'd1*H))+((E*9'd27)+(9'd18*D)))+((C*9'd27)+((B*9'd8)+(9'd28*A))))+(9'd28*F)))+((9'd0*J)+(I*9'd20))))+((P*9'd12)+(Q*9'd23)))));
  wire [8:0] 
       total_volume = (((W*9'd26)+((9'd11*Y)+(X*9'd3)))+((V*9'd16)+(9'd18*U)))+((((T*9'd13)+(9'd12*R))+(((9'd30*Q)+((9'd2*L)+(M*9'd9)))+((((9'd19*O)+(N*9'd28))+((9'd15*J)+(9'd12*I)))+(((9'd5*K)+(9'd4*G))+(((E*9'd0)+(F*9'd24))+((9'd20*H)+((9'd4*D)+((9'd4*C)+((B*9'd27)+(9'd27*A))))))))))+((9'd18*P)+(S*9'd28)));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule

