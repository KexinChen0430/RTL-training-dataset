
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd5*X)+(9'd0*Y))+(9'd3*V))+((9'd23*T)+(9'd18*W)))+((((9'd7*R)+(U*9'd24))+(((S*9'd29)+((M*9'd16)+(((9'd18*O)+(J*9'd15))+(((((H*9'd14)+(I*9'd6))+((((((9'd8*B)+(A*9'd4))+(C*9'd0))+(D*9'd20))+((9'd12*F)+(9'd18*G)))+(9'd10*E)))+(9'd8*L))+(9'd30*K)))))+((9'd14*P)+(9'd18*N))))+(9'd7*Q));
  wire [8:0] 
       total_weight = ((9'd10*Y)+(((U*9'd26)+(X*9'd21))+(W*9'd0)))+(((9'd15*V)+((P*9'd12)+(((9'd26*R)+((9'd22*O)+(9'd8*M)))+((((9'd13*L)+(9'd14*N))+(((I*9'd20)+((G*9'd6)+(F*9'd28)))+(((9'd8*B)+((9'd27*E)+(D*9'd18)))+((9'd28*A)+(9'd27*C)))))+(((9'd1*H)+(J*9'd0))+(K*9'd5))))))+(((9'd22*T)+(S*9'd1))+(9'd23*Q)));
  wire [8:0] 
       total_volume = ((((9'd18*U)+(W*9'd26))+(((9'd12*R)+((((J*9'd15)+((((9'd4*G)+(9'd12*I))+(((9'd4*C)+(F*9'd24))+(E*9'd0)))+((9'd4*D)+((B*9'd27)+(A*9'd27)))))+(9'd20*H))+(((M*9'd9)+(L*9'd2))+(K*9'd5))))+(((N*9'd28)+(O*9'd19))+(9'd18*P))))+((Q*9'd30)+((9'd13*T)+(S*9'd28))))+(((9'd16*V)+(9'd3*X))+(9'd11*Y));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule

