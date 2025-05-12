
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((U*9'd24)+(9'd5*X))+((((((R*9'd7)+(9'd29*S))+(O*9'd18))+((((9'd8*L)+((9'd18*N)+(M*9'd16)))+(((K*9'd30)+(9'd6*I))+(((F*9'd12)+((9'd18*G)+(((9'd20*D)+((B*9'd8)+(9'd10*E)))+((9'd4*A)+(C*9'd0)))))+((H*9'd14)+(J*9'd15)))))+((P*9'd14)+(Q*9'd7))))+((V*9'd3)+(9'd23*T)))+(W*9'd18));
  wire [8:0] 
       total_weight = (((W*9'd0)+(9'd21*X))+((((V*9'd15)+(U*9'd26))+(((9'd14*N)+(P*9'd12))+(((((9'd13*L)+(9'd5*K))+(M*9'd8))+(I*9'd20))+(((9'd0*J)+(G*9'd6))+(((H*9'd1)+((D*9'd18)+((B*9'd8)+(A*9'd28))))+(((9'd28*F)+(9'd27*E))+(9'd27*C)))))))+((9'd22*O)+((9'd26*R)+(9'd23*Q)))))+((9'd22*T)+(S*9'd1));
  wire [8:0] 
       total_volume = (((X*9'd3)+(W*9'd26))+((((9'd16*V)+((9'd28*N)+(((9'd18*P)+(((((9'd20*H)+(F*9'd24))+(9'd12*I))+((((9'd4*D)+(9'd4*C))+(9'd27*(B+A)))+((9'd4*G)+(E*9'd0))))+((J*9'd15)+(9'd5*K))))+((M*9'd9)+(9'd2*L)))))+((O*9'd19)+((Q*9'd30)+(9'd12*R))))+((T*9'd13)+(9'd28*S))))+(9'd18*U);

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule

