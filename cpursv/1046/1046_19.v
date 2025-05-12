
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd3*V)+(X*9'd5))+(((T*9'd23)+(R*9'd7))+(((((O*9'd18)+(9'd7*Q))+(((9'd30*K)+(((9'd16*M)+(H*9'd14))+(((((B*9'd8)+((9'd4*A)+(9'd20*D)))+((9'd0*C)+(F*9'd12)))+((G*9'd18)+(9'd10*E)))+((I*9'd6)+(J*9'd15)))))+((9'd18*N)+(9'd8*L))))+(9'd29*S))+(P*9'd14))))+((W*9'd18)+(U*9'd24));
  wire [8:0] 
       total_weight = ((X*9'd21)+(V*9'd15))+(((((((9'd26*R)+(Q*9'd23))+(S*9'd1))+((9'd22*O)+(N*9'd14)))+(((P*9'd12)+(9'd13*L))+(((9'd8*M)+(9'd5*K))+(((H*9'd1)+(J*9'd0))+(((((((9'd28*A)+(9'd18*D))+(B*9'd8))+(9'd27*E))+(9'd27*C))+(I*9'd20))+((9'd28*F)+(9'd6*G)))))))+(9'd26*U))+((W*9'd0)+(9'd22*T)));
  wire [8:0] 
       total_volume = ((((V*9'd16)+(9'd3*X))+(9'd26*W))+((9'd13*T)+(S*9'd28)))+((((U*9'd18)+(O*9'd19))+((((9'd30*Q)+(9'd18*P))+((((M*9'd9)+(9'd28*N))+((H*9'd20)+(G*9'd4)))+(((9'd12*I)+(((F*9'd24)+(((9'd27*B)+(A*9'd27))+((C*9'd4)+(9'd0*E))))+(D*9'd4)))+(J*9'd15))))+((L*9'd2)+(9'd5*K))))+(R*9'd12));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule

