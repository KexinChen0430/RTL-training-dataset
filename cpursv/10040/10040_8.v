
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((Y*9'd0)+(X*9'd5))+((R*9'd7)+(((P*9'd14)+((((M*9'd16)+(9'd18*O))+(L*9'd8))+(((9'd14*H)+(K*9'd30))+(((((9'd6*I)+(9'd15*J))+((9'd12*F)+(9'd20*D)))+(((9'd8*B)+(A*9'd4))+((9'd0*C)+(E*9'd10))))+(G*9'd18)))))+((9'd18*N)+(9'd7*Q)))))+(((T*9'd23)+(9'd29*S))+(9'd24*U)))+((V*9'd3)+(9'd18*W));
  wire [8:0] 
       total_weight = ((Y*9'd10)+((9'd26*U)+(V*9'd15)))+((((X*9'd21)+(W*9'd0))+(((9'd23*Q)+(9'd1*S))+(T*9'd22)))+((((9'd26*R)+(P*9'd12))+((M*9'd8)+(9'd13*L)))+((((9'd5*K)+(((9'd0*J)+((H*9'd1)+(9'd6*G)))+(((((9'd18*D)+(9'd27*E))+(F*9'd28))+((9'd8*B)+(9'd27*C)))+(9'd28*A))))+(9'd20*I))+((N*9'd14)+(9'd22*O)))));
  wire [8:0] 
       total_volume = ((9'd3*X)+((9'd26*W)+(Y*9'd11)))+((((R*9'd12)+(9'd30*Q))+(((9'd28*S)+(((9'd2*L)+(9'd5*K))+(((((9'd4*D)+(9'd0*E))+((((C*9'd4)+(9'd27*B))+(9'd27*A))+((F*9'd24)+(9'd4*G))))+(((9'd15*J)+(9'd12*I))+(H*9'd20)))+(N*9'd28))))+(((P*9'd18)+(M*9'd9))+(9'd19*O))))+(((9'd13*T)+(9'd16*V))+(U*9'd18)));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule

