
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((W*9'd18)+(Y*9'd0))+((((R+Q)*9'd7)+(((S*9'd29)+((O+N)*9'd18))+(((P*9'd14)+((K*9'd30)+((((I*9'd6)+(9'd18*G))+((((D*9'd20)+(9'd8*B))+(9'd4*A))+((9'd12*F)+(9'd0*C))))+((9'd10*E)+(H*9'd14)))))+((9'd15*J)+((9'd8*L)+(M*9'd16))))))+((U*9'd24)+(9'd23*T))))+((9'd3*V)+(9'd5*X));
  wire [8:0] 
       total_weight = ((((9'd22*T)+((9'd23*Q)+(S*9'd1)))+(((R*9'd26)+(((9'd14*N)+(9'd5*K))+(((9'd13*L)+((H*9'd1)+(J*9'd0)))+((((F*9'd28)+(9'd20*I))+((9'd6*G)+(9'd18*D)))+(((A*9'd28)+(E*9'd27))+((9'd8*B)+(9'd27*C)))))))+(((P*9'd12)+(M*9'd8))+(9'd22*O))))+((U*9'd26)+(W*9'd0)))+(((Y*9'd10)+(X*9'd21))+(V*9'd15));
  wire [8:0] 
       total_volume = (((9'd26*W)+((Y*9'd11)+(9'd3*X)))+(V*9'd16))+((9'd13*T)+(((9'd18*U)+((S*9'd28)+(9'd12*R)))+(((((9'd9*M)+(9'd19*O))+(((9'd20*H)+(9'd12*I))+(((((F*9'd24)+(9'd4*G))+((C+D)*9'd4))+(((9'd27*B)+(E*9'd0))+(9'd27*A)))+((9'd15*J)+(9'd5*K)))))+((N*9'd28)+(9'd2*L)))+((Q*9'd30)+(9'd18*P)))));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule

