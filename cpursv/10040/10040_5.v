
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((Y*9'd0)+(9'd5*X))+(V*9'd3))+(((W*9'd18)+((9'd29*S)+(9'd23*T)))+(((((N*9'd18)+(9'd18*O))+(((((J*9'd15)+(9'd18*G))+(((((9'd14*H)+(((9'd0*C)+(9'd20*D))+(B*9'd8)))+(A*9'd4))+(F*9'd12))+(E*9'd10)))+(9'd6*I))+(9'd16*M)))+((L*9'd8)+(9'd30*K)))+(((P*9'd14)+(Q*9'd7))+(R*9'd7)))))+(U*9'd24);
  wire [8:0] 
       total_weight = (((9'd0*W)+((Y*9'd10)+(9'd21*X)))+((((Q*9'd23)+(S*9'd1))+(9'd12*P))+(((R*9'd26)+((9'd13*L)+(M*9'd8)))+(((N*9'd14)+(O*9'd22))+(((((H*9'd1)+(9'd5*K))+(J*9'd0))+((I*9'd20)+(((9'd28*F)+(9'd27*E))+(((B*9'd8)+(9'd27*C))+((D*9'd18)+(9'd28*A))))))+(9'd6*G))))))+(((9'd22*T)+(U*9'd26))+(V*9'd15));
  wire [8:0] 
       total_volume = (((((9'd16*V)+(9'd13*T))+(U*9'd18))+((9'd12*R)+(Q*9'd30)))+(((9'd28*S)+(N*9'd28))+(((((9'd9*M)+(9'd2*L))+((9'd5*K)+(I*9'd12)))+(((9'd4*G)+(9'd20*H))+(((J*9'd15)+(((A*9'd27)+(C*9'd4))+(9'd27*B)))+(((9'd24*F)+(9'd0*E))+(D*9'd4)))))+((O*9'd19)+(9'd18*P)))))+(((Y*9'd11)+(X*9'd3))+(W*9'd26));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

