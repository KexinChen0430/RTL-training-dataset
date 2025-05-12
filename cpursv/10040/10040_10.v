
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd5*X)+(W*9'd18))+(9'd0*Y))+(9'd24*U))+((((((T*9'd23)+(S*9'd29))+(P*9'd14))+(((9'd7*Q)+(((9'd16*M)+(O*9'd18))+(9'd18*N)))+(((((9'd6*I)+(9'd30*K))+(L*9'd8))+((((((9'd20*D)+(C*9'd0))+(B*9'd8))+(A*9'd4))+((F*9'd12)+(9'd10*E)))+(9'd15*J)))+((9'd14*H)+(G*9'd18)))))+(R*9'd7))+(9'd3*V));
  wire [8:0] 
       total_weight = (((((X*9'd21)+(9'd10*Y))+((T*9'd22)+(9'd1*S)))+(((9'd26*U)+((P*9'd12)+(9'd22*O)))+((((9'd23*Q)+(9'd26*R))+(((9'd8*M)+(J*9'd0))+((((9'd5*K)+(L*9'd13))+((G*9'd6)+(9'd20*I)))+((((H*9'd1)+((9'd28*A)+(9'd27*C)))+((D*9'd18)+(B*9'd8)))+((E*9'd27)+(F*9'd28))))))+(9'd14*N))))+(9'd0*W))+(V*9'd15);
  wire [8:0] 
       total_volume = ((9'd11*Y)+(9'd16*V))+(((((S*9'd28)+((T*9'd13)+(U*9'd18)))+((P*9'd18)+(O*9'd19)))+((((9'd30*Q)+(9'd12*R))+(((9'd15*J)+(M*9'd9))+((((((C*9'd4)+(A*9'd27))+(9'd27*B))+((E*9'd0)+(D*9'd4)))+(((F*9'd24)+(9'd20*H))+(9'd4*G)))+((9'd5*K)+(I*9'd12)))))+((N*9'd28)+(9'd2*L))))+((9'd26*W)+(X*9'd3)));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

