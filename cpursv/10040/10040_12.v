
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd0*Y)+((V*9'd3)+(W*9'd18)))+(((9'd5*X)+(((R*9'd7)+(O*9'd18))+((((9'd7*Q)+(9'd14*P))+((N*9'd18)+(9'd8*L)))+(((M*9'd16)+((9'd6*I)+(H*9'd14)))+((((9'd30*K)+(9'd15*J))+(((D*9'd20)+(9'd12*F))+(9'd18*G)))+((C*9'd0)+(((A*9'd4)+(B*9'd8))+(E*9'd10))))))))+((S*9'd29)+((9'd24*U)+(T*9'd23))));
  wire [8:0] 
       total_weight = ((X*9'd21)+(((W*9'd0)+(((9'd23*Q)+(R*9'd26))+(((T*9'd22)+(9'd14*N))+((((P*9'd12)+((9'd5*K)+(9'd13*L)))+((((9'd28*F)+(((9'd1*H)+((9'd28*A)+(9'd27*C)))+(((D*9'd18)+(B*9'd8))+(9'd27*E))))+(((J*9'd0)+(9'd20*I))+(G*9'd6)))+(M*9'd8)))+(9'd22*O)))))+((9'd26*U)+(S*9'd1))))+((9'd15*V)+(9'd10*Y));
  wire [8:0] 
       total_volume = ((9'd16*V)+((Y*9'd11)+(X*9'd3)))+(((((((S*9'd28)+((((M*9'd9)+(P*9'd18))+((9'd2*L)+(9'd5*K)))+(((N*9'd28)+((9'd15*J)+(((9'd20*H)+((((E*9'd0)+(9'd27*B))+(C*9'd4))+(A*9'd27)))+(((F*9'd24)+(9'd4*D))+(G*9'd4)))))+(9'd12*I))))+((9'd30*Q)+(9'd19*O)))+(9'd18*U))+(9'd12*R))+(9'd26*W))+(9'd13*T));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

