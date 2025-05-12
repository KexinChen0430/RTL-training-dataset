
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd5*X)+((((9'd3*V)+(((((N*9'd18)+((((9'd6*I)+(9'd14*H))+(G*9'd18))+(((9'd12*F)+((C*9'd0)+(9'd8*B)))+((9'd4*A)+((E*9'd10)+(D*9'd20))))))+(((9'd8*L)+(9'd30*K))+(9'd15*J)))+(((M*9'd16)+(9'd18*O))+(9'd14*P)))+(9'd7*(Q+R))))+(9'd23*T))+(9'd29*S)))+((9'd18*W)+(U*9'd24));
  wire [8:0] 
       total_weight = ((V*9'd15)+((((((((9'd5*K)+((9'd13*L)+(M*9'd8)))+((9'd1*H)+(I*9'd20)))+(((9'd0*J)+((((9'd8*B)+(C*9'd27))+(9'd18*D))+(A*9'd28)))+(((9'd28*F)+(9'd6*G))+(E*9'd27))))+((N*9'd14)+(O*9'd22)))+(9'd1*S))+((9'd12*P)+(Q*9'd23)))+((9'd26*R)+(T*9'd22))))+(((U*9'd26)+(X*9'd21))+(W*9'd0));
  wire [8:0] 
       total_volume = (((V*9'd16)+((X*9'd3)+(9'd26*W)))+((9'd13*T)+(9'd28*S)))+((U*9'd18)+((((9'd12*R)+(Q*9'd30))+(((((9'd15*J)+(9'd2*L))+(9'd9*M))+(((9'd5*K)+(((((9'd24*F)+(9'd0*E))+(C*9'd4))+((9'd4*D)+(9'd27*B)))+(A*9'd27)))+((9'd4*G)+(H*9'd20))))+(9'd12*I)))+(((N*9'd28)+(O*9'd19))+(P*9'd18))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule

